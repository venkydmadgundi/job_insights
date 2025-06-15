module Api
  module V1
    class JobInsightsController < ApplicationController
      before_action :get_job

      def anomalies
        insights = JobAnalyticService.new(@job).anomalies
        render json: { anomalies: insights }
      end

      private

      def get_job
        @job = Job.find(params[:id])
      end
    end
  end
end