module Api
  module V1
    class SimilarJobsController < ApplicationController
      before_action :set_job

      def index
        similar_jobs = SimilarJobsService.new(
          @job,
          title: param_enabled?(:title),
          tags: param_enabled?(:tags),
          industry: param_enabled?(:industry)
        ).find_similar(limit: params[:limit]&.to_i || 5)

        render json: similar_jobs.as_json(include: [:views, :tags])
      end

      private

      def set_job
        @job = Job.find(params[:id])
      end

      def param_enabled?(key)
        return true unless params.key?(key)
        params[key] != 'false'
      end
    end
  end
end
