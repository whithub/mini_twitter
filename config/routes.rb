Rails.application.routes.draw do

  root 'welcome#index'

  get '/auth/twitter', as: :login #, to: 'dashboard#show'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show', as: :dashboard

end
