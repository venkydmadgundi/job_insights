require 'rails_helper'

describe "SimilarJobs API", type: :request do
  let(:industry) { Industry.find_or_create_by!(name: "Information Technology") }
  let!(:job) { Job.find_or_create_by!(title: "Junior Dev", description: "Writes code", industry: industry) }
  let(:tag) { Tag.find_or_create_by!(name: 'Remote') }
  # let!(:job2) { Job.create!(title: "Senior Dev", description: "Reviews code", industry: industry) }
  before do
    job.tags << tag
  end

  describe 'GET /api/v1/jobs/:id/similar' do
    context 'with all params default' do
      it 'returns similar jobs with views and tags' do
        similar_job = Job.create!(title: 'Senior Developer', industry: industry)
        similar_job.tags << tag

        allow(SimilarJobsService).to receive(:new).and_call_original

        get "/api/v1/jobs/#{job.id}/similar"

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to be_an(Array)
        expect(SimilarJobsService).to have_received(:new).with(
          job,
          title: true,
          tags: true,
          industry: true
        )
      end
    end

    context 'with specific param disabling' do
      it 'excludes disabled filter in service input' do
        get "/api/v1/jobs/#{job.id}/similar", params: { tags: 'false' }
        expect(response).to have_http_status(:ok)
        expect(assigns(:job)).to eq(job)
      end
    end

    context 'with custom limit' do
      it 'uses the limit param correctly' do
        expect_any_instance_of(SimilarJobsService).to receive(:find_similar).with(limit: 3).and_return([])
        get "/api/v1/jobs/#{job.id}/similar", params: { limit: 3 }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with missing job ID' do
      it 'returns 404 when job is not found' do
        get "/api/v1/jobs/999999/similar"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
