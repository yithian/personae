Personae::Application.routes.draw do
  devise_for :users

  resource :admin do
    collection do
      post 'manage'
    end
  end

  resources :chronicles
  resources :ideologies
  resources :cliques
  resources :characters do
    resources :comments
  end
  
  root :to => 'characters#index'
  match '/:controller(/:action(/:id))'
end
