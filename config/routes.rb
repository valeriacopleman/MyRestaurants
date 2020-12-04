Rails.application.routes.draw do
  
  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'callbacks'}
  root to: 'restaurants#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: 'login'
    get 'signup', to: 'devise/registrations#new', as: 'signup'
  end
  
  resources :categories
  resources :restaurants

end
