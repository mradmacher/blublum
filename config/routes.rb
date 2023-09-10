Rails.application.routes.draw do
  namespace :admin do
    get '/frames', to: 'frames#index'
    post '/frames', to: 'frames#create'
    get '/lenses', to: 'lenses#index'
    post '/lenses', to: 'lenses#create'
  end

  namespace :user do
    get '/frames', to: 'frames#index'
    get '/lenses', to: 'lenses#index'
    post '/orders', to: 'orders#create'
  end
end
