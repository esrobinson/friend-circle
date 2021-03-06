FriendCircle::Application.routes.draw do
  root :to => "users#feed"

  resources :users, :only => [:new, :create, :edit, :update]

  resource :session, :only => [:new, :create, :destroy] do
    get "/forgot_password", :to => 'sessions#forgot_password'
    post "/forgot_password", :to => 'sessions#mail_password'
    get "/reset_password/:token", :to => 'sessions#reset_password'
  end

  resources :circles

  resources :posts, :only => [:new, :create, :destroy] do
    resources :upvotes, :only => [:create]
  end

  resources :upvotes, :only => [:destroy]

  get "/feed", :to => "users#feed"

end