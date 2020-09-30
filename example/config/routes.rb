Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :buildings, only: %i(index show create update), param: :uuid do
        resources :firms, only: %i(index create)
      end
      resources :firms, only: %i(show update), param: :uuid do
        resources :users, only: %i(index create)
      end
      resources :users, only: %i(show update), param: :uuid
    end
  end
end
