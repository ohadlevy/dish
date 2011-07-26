Dish::Application.routes.draw do
  resources :hosts, :constraints => {:id => /[^\/]+/}
  resources :packages,  :constraints => {:id => /[^\/]+/}
  match '/' => 'packages#index'
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  resources :sessions
  resources :users
  match '/:controller(/:action(/:id))'
end
