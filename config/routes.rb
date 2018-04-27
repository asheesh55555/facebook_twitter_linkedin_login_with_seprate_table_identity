Rails.application.routes.draw do
 # devise_for :users
 match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
 
resources :articles do
  
  resources :endorses
end
 
devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "home#index"
  resources :conversations, only: [:create] do
    member do
      post :close
    end
     resources :messages, only: [:create]
  end

resources :article do
  member do
    get "like", to: "articles#upvote"
    get "dislike", to: "articles#downvote"
  end
end

resources :users do
    resources :follows
end







namespace :api do

resources :oauth_callbacks, only: [] do 
      collection do 
        post '/facebook', to:  'oauth_callbacks#facebook'
        post '/google',   to:  'oauth_callbacks#google'
      end
    end
end













get "/tagging" => "articles#tag"
get "/user/profile" => "users#show"
get "/user/follow1111" => "users#follow"
get "/user/following" => "follows#following"
get "/user/follower" => "follows#follower"
get "/user/notification" => "users#notification"
get "/user/addfriend" => "users#friend"
get "/user/acc" => "users#accept_friend"
get "/user/de" => "users#delete_friend"


end


 
  