Rails.application.routes.draw do
  root 'home#home'
  
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard
end
