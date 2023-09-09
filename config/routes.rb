Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    get '/frames', to: 'frames#index'
    post '/frames', to: 'frames#create'
  end

  namespace :user do
    get '/frames', to: 'frames#index'
  end
end
