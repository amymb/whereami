Rails.application.routes.draw do
  resources :users
  get 'user/current' => 'users#current'

  resources :floorplans
  root 'home#index'

  get '/about' => 'home#about'
  post 'authenticate', to: 'authentication#authenticate'
  post '/location' => 'pusher#location'
  post '/pusher/auth' => 'pusher#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
