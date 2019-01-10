Rails.application.routes.draw do

  root 'homepage#index'

  get '/auth/github', to: 'authentication#github'


  resources :users, only: [:index]
  # resources :repos, only: [:index]
  resources :classes, only: [:index, :create, :update, :destroy] do
    resources :repos, only: [:index]
  end
  resources :prs, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
