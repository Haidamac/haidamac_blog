Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :authors
      resources :tags do
        resources :articles do
        end
      end

      resources :articles do
        resources :comments do
        end
      end

      resources :articles do
        resources :likes, only: %i[create destroy]
      end

      resources :articles do
        resources :comments do
          resources :likes, only: %i[create destroy]
        end
      end

      get 'search', to: 'articles#search'
      get 'order', to: 'articles#order'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
