Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :jobs, only: [] do
        member do
          get 'similar', to: 'similar_jobs#index'
        end
      end
    end
  end
end