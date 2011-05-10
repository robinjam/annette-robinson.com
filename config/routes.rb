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
    end

    resources :images, :only => [:new, :create, :destroy],
      :controller => 'album_images' do
      member do
        post 'promote'
        post 'demote'
      end
    end
  end

  root :to => 'albums#first'
end
