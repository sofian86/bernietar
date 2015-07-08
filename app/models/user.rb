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

  # Create a client so we can tweet, update images, etc.
  def establish_twitter_client
    # Get the oauth info
    user_token = identities.where(provider:'twitter').pluck(:token).join(" ")
    user_secret = identities.where(provider:'twitter').pluck(:secret).join(" ")

    # Setup the client (assuming we have the token and secret)
    unless user_token.nil? && user_secret.nil?
      # Establish a Twitter client connection
      client = Twitter::REST::Client.new do |config|
          config.consumer_key         = Rails.application.secrets.twitter_consumer_key
          config.consumer_secret      = Rails.application.secrets.twitter_consumer_secret
          config.access_token         = user_token
          config.access_token_secret  = user_secret
      end
    end
  end
end
