Rails.application.routes.draw do

  root 'seats#index'

  namespace "something" do
    get :email_ticket
  end

  namespace :onlineticketing do
    resources :events, only: [] do
      member do
        get :hold_seat
        post :purchase_seat
      end
    end
  end



  namespace :ssmanagment do
    devise_for :admins, :skip => :registrations
    # admin_root_path :ssmanagment_events
    get    'secretdoor'  => "navigation#page_listing", as: :admin_root_path
    resources :events, only: [:create, :index, :show, :update] do
      resources :seats, only: [:show] do
        # member do
        #   post :update
        #   post :reserve
        #   post :refund #Check backend to see if purchased, prompt warning if so.
        # end
      end
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
