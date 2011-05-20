AnnetteRobinson::Application.routes.draw do
  resources :images do
    member do
      get 'delete'
    end
  end
  
  resources :albums do
    member do
      get 'delete'
      post 'promote'
      post 'demote'
      post 'move'
    end

    resources :images, :only => [:new, :create, :destroy],
      :controller => 'album_images' do
      member do
        post 'promote'
        post 'demote'
        post 'move'
      end
    end
  end

  resources :messages

  match 'images/:id/:style', :controller => 'images', :action => 'download', :via => :get

  match 'login' => 'sessions#new', :via => :get
  match 'login' => 'sessions#create', :via => :post
  match 'logout' => 'sessions#destroy', :via => :get

  root :to => 'albums#first'
end
