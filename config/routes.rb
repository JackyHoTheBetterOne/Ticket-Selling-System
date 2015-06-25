Rails.application.routes.draw do

  root 'seats#index'

  namespace "something" do
    get :email_ticket
  end

  namespace :onlineticketing do
    resources :events, only: [] do

      member do
        get :seat_update
        get :seat_view
        get :event_listing
        post :seat_selection
        post :seat_purchase
        post :seat_unhold
        post :ticket_scan
      end
    end
  end

  namespace :ssmanagment do
    root 'events#index'
    devise_for :admin,
      skip: [:registrations, :edit, :password],
      path_names: {
                    sign_in: "login",
                    sign_out: "logout"
                  },
      controllers: { sessions: "ssmanagment/admin/sessions" }
    # authenticated do # all other roles
    #   root :to => 'events#index', :as => :admin_root
    # end
    # authenticated :admin do
      # root :to => 'events#index', :as => :admin_root
    # end
    resources :events, only: [:new, :create, :index, :show, :update, :destroy] do
      post :copy, on: :member
      get :admin, on: :member
      resources :seats, only: [:show]
    end
  end

  namespace :scanner do
    namespace :api do
      resources :events, only: [] do
        resources :seats, only: [] do
          member do
            get :find
            post :scan
          end
        end
      end
    end
  end



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
