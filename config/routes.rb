Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'html_pages#home'
  get '/home', to: 'html_pages#home'
  get '/help', to: 'html_pages#help'
  get '/about', to: 'html_pages#about'
  get '/howitworks', to: 'html_pages#howitworks'
  get '/terms', to: 'html_pages#terms'
  get '/privacypolicy', to: 'html_pages#privacypolicy'
  get '/cookiepolicy', to: 'html_pages#cookiepolicy'
  get '/contact', to: 'html_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :spaces do
    resources :reservations,      only: [:create, :index]
  end
  resources :reservations,        only: [:create, :index]
  resources :spaces,              only: [:new, :show, :index, :create,
                                         :edit, :update, :destroy]
  resources :artworks,            only: [:new, :show, :index, :create,
                                         :edit, :update, :destroy]

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'

end
