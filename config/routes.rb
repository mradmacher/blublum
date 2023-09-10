Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    get '/frames', to: 'frames#index'
    post '/frames', to: 'frames#create'
    get '/lenses', to: 'lenses#index'
    post '/lenses', to: 'lenses#create'
  end

  namespace :user do
    get '/frames', to: 'frames#index'
    get '/lenses', to: 'lenses#index'
  end
end
