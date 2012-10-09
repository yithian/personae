Personae::Application.routes.draw do
  get "root/root"

  root :to => 'root#root'

  resources :chronicles do
    collection do
      get 'change_selected_chronicle'
    end
    
    resources :characters do
      collection do
        get 'update_splat'
        get 'possess'
        get 'update_nature'
        get 'update_chronicle'
      end
      member do
        put 'save_notes'
        put 'save_current'
        get 'shapeshift'
        get 'preview'
      end
      resources :comments
    end

    resources :cliques
  end

  resources :natures
  resources :ideologies

  devise_for :users

  post "services/obsidian_connect", :as => "obsidian_connect"
  post "services/obsidian_disconnect", :as => "obsidian_disconnect"
  
  get "admin/manage", :as => "manage_admins"
end
