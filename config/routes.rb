Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index]

  resource :checkout, only: [:show] do
    post :scan, on: :collection
    post :clear, on: :collection
  end
end
