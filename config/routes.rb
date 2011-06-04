Personae::Application.routes.draw do
  devise_for :users

  resources :chronicles

  resources :users
  resources :ideologies
  resources :cliques
  resources :characters do
    resources :comments
  end
  
  root :to => 'characters#index'
  match '/:controller(/:action(/:id))'
end
