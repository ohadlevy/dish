Dish::Application.routes.draw do
  constraints(:id => /[^\/]+/) do
    resources :hosts do
      get 'auto_complete_search', :on => :collection
    end
    resources :packages do
      get 'auto_complete_search', :on => :collection
    end
  end

  match '/' => 'packages#index'
end
