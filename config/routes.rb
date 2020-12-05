Rails.application.routes.draw do
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
  resources :users

end
