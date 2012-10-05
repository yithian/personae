Personae::Application.routes.draw do
  post "services/obsidian_connect", :as => "obsidian_connect"
  post "services/obsidian_disconnect", :as => "obsidian_disconnect"
  
  get "admin/manage", :as => "manage_admins"

  devise_for :users

  resources :chronicles do
    resources :characters do
      collection do
        get 'update_splat'
        get 'possess'
        get 'update_nature'
        get 'update_chronicle'
        get 'change_chronicle'
      end
      member do
        put 'save_notes'
        put 'save_current'
        get 'shapeshift'
        get 'preview'
      end
      resources :comments
    end

    resources :cliques do
      collection do
        get 'change_chronicle'
      end
    end

    resources :natures
    resources :ideologies
  end

  root :to => 'chronicles#index'
end
