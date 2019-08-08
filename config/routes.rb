Rails.application.routes.draw do
  resources :users
  resources :floorplans
  root 'home#index'

  get '/about' => 'home#about'
  post 'authenticate', to: 'authentication#authenticate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
