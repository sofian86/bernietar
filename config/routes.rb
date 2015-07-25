Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  # User page
  resources :users, only: [:show]

  # :network identifies Twittter, Facebook, etc.
  get '/explanation/facebook', to: 'facebook_actions#explanation', as: :facebook_explanation
  get '/explanation/twitter', to: 'twitter_actions#explanation', as: :twitter_explanation

  get '/twitter/avatar', to: 'twitter_actions#foobar', as: :twitter_avatar

  # Update Twitter profile images
  match '/twitter/update', to: 'twitter_actions#update_twitter', via: [:post], as: :update_twitter

  # Upload the Bernietar to Facebook
  match '/facebook/upload', to: 'facebook_actions#upload_facebook_bernietar', via: [:post], as: :upload_facebook

  # Displayed after user has just change to Bernietar on a social network
  match ':network/all-done', to: 'pages#all_done', via: :get, as: :social_done

end
