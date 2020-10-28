Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :states, param: :slug
      resources :counties, only: [:create, :update]
    end
  end
  get '*path', to: 'homepage#index', via: :all
  root 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
