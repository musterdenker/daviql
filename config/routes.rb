Daviql::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'


  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :dashboards

  resources :queries, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :queries
    end
  end

  root to: 'facade#start'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  get ':controller(/:action(/:id))(.:format)'
end
