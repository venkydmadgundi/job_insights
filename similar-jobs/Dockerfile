FROM base AS similarity

ENV SERVICE_NAME=similarity
EXPOSE 3001

COPY ./similar-jobs/services/similar_jobs_service.rb ./app/services/similar_jobs_service.rb
COPY ./similar-jobs/controllers/similar_jobs_controller.rb ./app/controllers/api/v1/similar_jobs_controller.rb
COPY ./similar-jobs/spec/requests/similar_jobs_spec.rb ./spec/requests/similar_jobs_spec.rb
COPY ./similar-jobs/spec/services/similar_jobs_service_spec.rb ./spec/services/similar_jobs_service_spec.rb
COPY ./similar-jobs/models/* ./app/models/
COPY ./similar-jobs/routes.rb ./config/routes.rb
CMD [ "rails", "server", "-b", "0.0.0.0","-p", "3001"]
