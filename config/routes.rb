Personae::Application.routes.draw do
  resources :users
  resources :ideologies
  resources :cliques
  resources :characters do
    resources :comments
  end

  match '/login', :to => 'admin#login', :as => 'login'
  root :to => 'characters#index'
  match '/:controller(/:action(/:id))'
end
