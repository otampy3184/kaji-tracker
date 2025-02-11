Rails.application.routes.draw do
  namespace :api do
    resources :kajis, only: [:index, :create]
    resources :users, only: [:index, :create]
    resources :kaji_records, only: [:index, :create]
  end
end
