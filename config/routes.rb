Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :deletable do
    get :delete, on: :member
  end

  concern :moveable do
    post :move, on: :member
  end


  resources :images, concerns: [:deletable]

  resources :albums, concerns: [:deletable, :moveable] do
    resources :images, only: [:new, :create, :destroy], concerns: [:moveable], controller: 'album_images'
  end

  post '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  root to: 'albums#first'
end
