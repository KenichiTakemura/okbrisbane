Okbrisbane::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  resources :mypages, :only => ['index','edit','update']

  match 'counters/batch', :via => :get

  match 'users/member_managements/sign_in', :via => :get, :as => :user_sign_in
  match 'users/member_managements/sign_up', :via => :get, :as => :user_sign_up
  match 'users/member_managements/sign_out', :via => :get, :as => :user_sign_out
  match 'users/member_managements/term', :via=>:get, :as => :termsofservice
  match 'users/member_managements/personal', :via=>:get, :as => :termsofpersonal
  match 'users/member_managements/agreememnt_required', :via=>:get, :as => :agreement
  match 'users/member_managements/agreed', :via=>:get, :as => :agreed
  match 'users/member_managements/inactive_signup', :via=>:get, :as => :user_inactive_signup
  match 'users/member_managements/sending_reset_password_instructions', :via=>:get, :as => :user_sending_reset_password_instructions
  match 'users/member_managements/after_reset_password', :via=>:get, :as => :user_after_reset_passwod
  match 'users/member_managements/after_confirmation', :via=>:get, :as => :user_after_confirmation
  match 'users/member_managements/after_resending_confirmation_instructions', :via=>:get, :as => :user_after_resending_confirmation_instructions

  namespace :users do
    resources :member_managements, :only => ["index","new","create"]
  end
  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions", :confirmations => "users/confirmations", :passwords => "users/passwords", :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :images, :only => ["create","destroy", "index"]
  resources :attachments, :only => ["create","destroy", "index"]

  resources :sponsors, :only => [] do
    collection do
      get :show
      get :show_ok
      get :thank_you
    end
  end

  resource :banners, :only => [] do
    collection do
      post :show_single_banner
      post :show_multi_banner
    end
  end

  resources :contacts, :only => ["index","create","new"]

  resources :homes, :only => ["index"] do
    collection do
      post :current_weather
      post :current_rate
      post :top_feed
      post :admin_notice
      get  :topic_feed
    end
  end
  
  resources :business_clients do
    collection do
      post :select_category
      get :query
      post :search
    end
  end

  resources :post_searches, :only => ["index","create","edit","update"]

  resources :okboards, :only => ['index'] do
    collection do
      get :mypage
      get :yellowpage
      post :more
      post :post_admin_notice
      get :view
      get :write
      post :upload_image
      post :upload_attachment
      post :get_image
      post :get_attachment
      delete :delete_image
      delete :delete_attachment
      post :likes
      post :dislikes
      post :abuses
      post :next_post
      post :prev_post
    end
  end

  resources :jobs, :only => ["new","create"]
  resources :buy_and_sells, :only => ["new","create"]
  resources :well_beings, :only => ["new","create"]
  resources :accommodations, :only => ["new","create"]
  resources :laws, :only => ["new","create"]
  resources :taxes, :only => ["new","create"]

  match 'comments/:id/likes' => "comments#likes", :via=>:post, :as => :comment_like
  match 'comments/:id/dislikes' => "comments#dislikes", :via=>:post, :as => :comment_dislike
  match 'comments/:id/abuses' => "comments#abuses", :via=>:post, :as => :comment_abuse
  match 'comments/:id/new' => "comments#new", :via=>:get, :as => :comment_new
  match 'comments/:id/reply' => "comments#reply", :via=>:post, :as => :comment_reply
  resources :comments, :only => ['index',"create"] do
    collection do
      post :dislike
      post :abuse
      post :post_for
    end
  end

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
