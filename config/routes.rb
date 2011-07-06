Personae::Application.routes.draw do
  devise_for :users

  resource :admin do
    collection do
      post 'manage'
    end
  end

  resources :chronicles
  resources :ideologies

  resources :cliques do
    collection do
      get 'change_chronicle'
    end
  end

  resources :characters do
    collection do
      get 'update_splat'
      get 'update_nature'
      get 'update_chronicle'
      get 'change_chronicle'
    end
    member do
      get 'shapeshift'
      get 'preview'
    end
    resources :comments
  end
  
  root :to => 'characters#index'
  match '/:controller(/:action(/:id))'
end
