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
  get '/explanation/:network', to: 'social#explanation', as: :explanation

  # Update Twitter profile images
  match '/twitter/update', to: 'users#update_twitter', via: [:post], as: :update_twitter

  # Upload the Bernietar to Facebook
  match '/facebook/upload', to: 'users#upload_facebook_bernietar', via: [:post], as: :upload_facebook

  # Displayed after user has just change to Bernietar on a social network
  match ':network/all-done', to: 'social#all_done', via: :get, as: :social_done

end
