Rails.application.routes.draw do
  #get :token, controller: 'application'
  resources :users, except: [:new, :edit]
  resources :songs, except: [:new, :edit]
  resources :tabs_sets, except: [:new, :edit]
  resources :lyrics_sets, except: [:new, :edit]

  get 'get_tabs_sets', to: 'tabs_sets#get_tabs_sets'
  get 'get_lyrics_sets', to: 'lyrics_sets#get_lyrics_sets'
  get 'attempt_login', to: 'users#attempt_login'
  get 'validate_email', to: 'users#validate_email'

  resources :tabs_sets do
  member do
    put "like", to: "tabs_sets#upvote"
    put "dislike", to: "tabs_sets#downvote"
    end
  end

  resources :lyrics_sets do
  member do
    put "like", to: "lyrics_sets#upvote"
    put "dislike", to: "lyrics_sets#downvote"
    end
  end

  #match ':controller(/:action(/:id))', :via => [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
