Okbrisbane::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  
  resources :mypages, :only => ['show']

  match 'member_managements/sign_in', :via => :get, :as => :user_sign_in
  match 'member_managements/sign_up', :via => :get
  match 'member_managements/sign_out', :via => :get, :as => :user_sign_out
  match 'member_managements/term', :via=>:get, :as => :termsofservice
  match 'member_managements/personal', :via=>:get, :as => :termsofpersonal
  resources :member_managements, :only => ["index","new","create"]

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }

  resources :homes, :only => ["index"]
  
  resources :okboards, :only => ['index'] do
    collection do
      post :more
      get :view
      get :write
      post :upload_image
      post :upload_attachment
      post :get_image
      post :get_attachment
      delete :delete_image
      delete :delete_attachment
    end
  end
  
  resources :jobs, :only => ["new","create"]
  resources :buy_and_sells, :only => ["new","create"]
  resources :well_being, :only => ["new","create"]

  resources :post_searches, :only => ["index"]
  
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
  #     end    get   "member_management/sign_up" => "registrations#new", :as => :user_signup
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
  root :to => 'homes#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
