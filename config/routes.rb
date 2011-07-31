Personae::Application.routes.draw do
  post "services/obsidian_connect", :as => "obsidian_connect"
  post "services/obsidian_disconnect", :as => "obsidian_disconnect"
  
  get "admin/manage", :as => "manage_admins"

  devise_for :users

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
