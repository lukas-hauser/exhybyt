Rails.application.routes.draw do
  get 'html_pages/help'
  get 'html_pages/about'
  get 'html_pages/howitworks'
  get 'html_pages/terms'
  get 'html_pages/privacypolicy'
  get 'html_pages/cookiepolicy'
  root 'html_pages#home'
end
