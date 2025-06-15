require 'rails_helper'

describe "JobInsights API", type: :request do
  let(:industry) { Industry.find_or_create_by!(name: "Healthcare") }
  let!(:job) { Job.create!(title: "Nurse", description: "Care for patients", industry: industry, clicks: 0) }

  it "returns low_views anomaly when no recent views" do
    get "/api/v1/jobs/#{job.id}/insights"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("low_views")
  end
end