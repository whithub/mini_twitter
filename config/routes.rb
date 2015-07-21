Rails.application.routes.draw do

  root 'home#index'

  get '/auth/twitter', as: :login #, to: 'dashboard#show'
  # get '/login', to: 'dashboard#show'

  get 'dashboard', to: 'dashboards#show'

  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


end
