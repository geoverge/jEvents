Jevents::Application.routes.draw do

  match '/profiles/dashboard' => 'profiles#dashboard', :as => :user_root

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :profiles, :only => [:dashboard]
  resources :feedbacks, :only => [:new, :create]
  resources :venue_requests, :only => [:new, :create]

  namespace :admin do
    match '/' => 'admin#index'
    resources :users
    resources :venues, :only => [:index, :destroy]
    resources :venue_requests, :only => [:index, :destroy]
    resources :feedbacks, :only => [:index, :destroy]
  end
  
  resources :venues, :except => [:destroy] do
    resources :halls
    resource :images
    
    member do   #member - requires an ID
      get 'rates'
      get 'facilities'
      get 'highlights'
    end
    collection do   #works on a collection, does not require an ID
      get 'show_image'
      get 'view' 
      get 'search'
      post 'search'
    end
  end

  get "home/index"
  get "home/about"
  get "home/faq"
  get "home/terms"
  get "home/privacy"
  
  get 'placeholder' => 'pages#placeholder'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
