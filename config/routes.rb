Contacts::Application.routes.draw do
  devise_for :users,
    :controllers => {
		:omniauth_callbacks => "users/omniauth_callbacks"
	}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  resources :mobiles
  resources :user_friend_invites
  resources :contact_imports
  resources :addresses
  resources :friendship
  resources :user_albums
  resources :user_photos
  
  post '/search' => "addresses#search" ,:as=>"address_search"
  post '/alphabetical' => "addresses#alphabetical" ,:as=>"alphabetical_search"
  get '/friends' => "friendship#index" ,:as=>"friends"
  get '/accept/:friend_id/friend/:id' =>"user_friend_invites#accept" ,:as=>"approve"
  get '/reject/:friend_id/friend/:id' =>"user_friend_invites#reject" ,:as=>"reject"
  get 'opensearch' =>"application#opensearch" ,:as=>"opensearch"

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
