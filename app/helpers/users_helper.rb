module UsersHelper

  def do_it_link(provider)
    case provider
      when 'twitter'
        link_to 'Okay, do it!', update_twitter_path, method: :post, class: 'btn btn-lg btn-success'
      when 'facebook'
        link_to 'Okay, do it!', upload_facebook_path, method: :post, class: 'btn btn-lg btn-success'
    end
  end

end
