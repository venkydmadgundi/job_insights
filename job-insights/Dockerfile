FROM base AS insights

ENV SERVICE_NAME=insights
EXPOSE 3000

COPY ./job-insights/services/job_analytic_service.rb ./app/services/job_analytic_service.rb
COPY ./job-insights/controllers/job_insights_controller.rb ./app/controllers/api/v1/job_insights_controller.rb
COPY ./job-insights/spec/requests/job_insights_spec.rb ./spec/requests/job_insights_spec.rb
COPY ./job-insights/spec/services/job_analytic_service_spec.rb ./spec/services/job_analytic_service_spec.rb
COPY ./job-insights/routes.rb ./config/routes.rb

CMD [ "rails", "server", "-b", "0.0.0.0"]