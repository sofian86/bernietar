class User < ActiveRecord::Base
  has_many :identities, dependent: :destroy

  TEMP_EMAIL_PREFIX = 'temporary@bernietar'
  TEMP_EMAIL_REGEX = /\Atemporary@bernietar/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Set the user's oauth token and secret (if available)

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            name: auth.extra.raw_info.name,
            #username: auth.info.nickname || auth.uid,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user

      # Add the token and secret if nil
      # Twitter first. Might need a few conditions for the various networks
      identity.token  = auth.credentials.token if !auth.credentials.token.nil?
      identity.secret = auth.credentials.secret if !auth.credentials.secret.nil?
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  # Return the current avatar for the appropriate provider
  def current_provider_avatar(provider)
    case provider
      when 'twitter'
        client = twitter_client
        client.user.profile_image_uri(size = :original)
      when 'facebook'
        graph = facebook_graph
        uid = graph.get_object('me')['id']
        graph.get_picture(uid, type:'large')
    end
  end

  def save_bernietar_id(id, provider)
    identity = facebook_identity
    identity.bernietar_location = id
    identity.save
  end

  def bernietar_set?(provider)
    case provider
    when 'twitter'
      has_twitter_bernietar?
    when 'facebook'
      has_facebook_bernietar?
    end
  end

  # Create a client so we can tweet, update images, etc.
  def twitter_client
    # Get the oauth info
    user_token  = twitter_identity.token
    user_secret = twitter_identity.secret

    # Setup the client (assuming we have the token and secret)
    unless user_token.blank? && user_secret.blank?
      # Establish a Twitter client connection
      Twitter::REST::Client.new do |config|
        config.consumer_key = Rails.application.secrets.twitter_consumer_key
        config.consumer_secret = Rails.application.secrets.twitter_consumer_secret
        config.access_token = user_token
        config.access_token_secret = user_secret
      end
    end
  end

  # Create a facebook graph connection
  def facebook_graph
    user_token  = facebook_identity.token
    # Setup the graph
    Koala::Facebook::API.new(user_token) unless user_token.blank?
  end

  def facebook_identity
    identities.find_by_provider 'facebook'
  end

  def twitter_identity
    identities.find_by_provider 'twitter'
  end

  private

  # Check to see if there is a known bernietar already uploaded to the user's
  # account
  def has_facebook_bernietar?
    graph = facebook_graph
    bernietar_location = facebook_identity.bernietar_location
    if bernietar_location
      # This returns a URI regardless. We have to check for a substring match
      # using the ID we saved when first uploading
      picture = graph.get_picture(bernietar_location)
      true if picture.include?(bernietar_location)
    end
  end

  def has_twitter_bernietar?
    client = twitter_client
    client.user.profile_image_uri()
  end

end
