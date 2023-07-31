Rails.application.routes.draw do
  root 'home#home'
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'

  get '/admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard
end
