Minimal::Application.routes.draw do
  root :to => "pages#home"

  get :home, :to => "pages#home"

  scope :module => :dashboard do
    resources :posts, :except => [:index, :show]
  end

  # auth
  scope :module => :auth do

    get   :login,   :to => "sessions#new"
    post  :login,   :to => "sessions#create"
    match :logout,  :to => "sessions#destroy"

    resources :password_resets do
      collection do
        match :confirmation
      end
    end

    resources :registrations

  end


  resources :users, :only => [:index, :show]
  resources :posts, :only => :show

end
