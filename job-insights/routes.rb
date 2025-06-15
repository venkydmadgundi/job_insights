Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :jobs, only: [] do
        member do
          get 'insights', to: 'job_insights#anomalies'
        end
      end
    end
  end
end
