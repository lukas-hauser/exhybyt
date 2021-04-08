Rails.application.routes.draw do
  root 'html_pages#home'
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/home',          to: 'html_pages#home'
  get '/help',          to: 'html_pages#help'
  get '/about',         to: 'html_pages#about'
  get '/howitworks',    to: 'html_pages#howitworks'
  get '/terms',         to: 'html_pages#terms'
  get '/privacypolicy', to: 'html_pages#privacypolicy'
  get '/cookiepolicy',  to: 'html_pages#cookiepolicy'
  get '/contact',       to: 'html_pages#contact'
  get '/search',        to: 'html_pages#search'
  get 'art',            to: 'html_pages#browse_art'
  get 'faq',            to: 'html_pages#faq'
  get '/signup',        to: 'users#new'
  get '/login',         to: 'sessions#new'
  get '/preload',       to: 'reservations#preload'
  get '/preview',       to: 'reservations#preview'
  get '/your_bookings',       to: 'reservations#your_bookings'
  get '/your_reservations',   to: 'reservations#your_reservations'
  get 'exhibitions',  to: 'reservations#current_exhibitions'
  get 'upcoming_exhibitions', to: 'reservations#upcoming_exhibitions'
  get 'past_exhibitions',     to: 'reservations#past_exhibitions'
  get "stripe/connect", to: "stripe#connect", as: :stripe_connect
  get "stripe/dashboard/:user_id", to: "stripe#dashboard", as: :stripe_dashboard
  post '/login',        to: 'sessions#create'
  delete '/logout',     to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations,     only: [:edit]
  resources :password_resets,         only: [:new, :create, :edit, :update]
  resources :relationships,           only: [:create, :destroy]
  resources :spaces do
    resources :reservations,          only: [:create, :index], shallow: true
  end
  resources :artworks do
    resources :orders,          only: [:create, :index], shallow: true
  end
  resources :artworks do
    member do
      delete :delete_image_attachment
    end
  end
  resources :spaces do
    member do
      delete :delete_image_attachment
    end
  end
  resources :spaces,                  only: [:new, :show, :index, :create,
                                            :edit, :update, :destroy]
  resources :artworks,                only: [:new, :show, :index, :create,
                                            :edit, :update, :destroy]
  resources :conversations,           only: [:index, :create] do
    resources :messages,              only: [:index, :create], shallow: true
  end

  resources :spaces do
    resources :reviews,               only: [:create, :destroy], shallow: true
  end

  resources :reservation_approvals,   only: [:edit]
  resources :reservation_rejections,  only: [:edit]

  resources :reservations do
    get 'payment', to: 'reservations#payment'
  end

  resources :orders do
    get 'payment', to: 'orders#payment'
  end

  get 'reservation_success', to: 'reservations#success'
  get 'reservation_cancel',  to: 'reservations#cancel'

  get 'order_success',       to: 'orders#success'
  get 'order_cancel',        to: 'orders#cancel'
end
