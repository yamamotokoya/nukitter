Rails.application.routes.draw do
  get "pages/terms"
  get "pages/privacy"
  root "posts#index"
  get "confirm_age", to: "welcome#confirm_age"
  post "approve_age", to: "welcome#approve_age"
  resources :users
  resources :posts
  resources :streamers do
  resources :posts, only: [:create, :destroy, :edit, :update] # streamerに紐づく投稿の作成
end
  resources :genres, only: [:show, :new, :create]
  resources :posts do
  resource :likes, only: [:create, :destroy]
end
  resource :history, only: [:destroy]
  


  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  "signup", to: "users#new"
  post "signup", to: "users#create"

  get 'sidebar', to: 'application#sidebar', as: :sidebar

  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
