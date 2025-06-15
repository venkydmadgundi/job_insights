require 'rails_helper'

describe SimilarJobsService do
  let(:industry) { Industry.find_or_create_by!(name: "Information Technology") }
  let!(:tag1) { Tag.find_or_create_by!(name: "Remote") }
  let!(:tag2) { Tag.find_or_create_by!(name: "Full-time") }

  let(:job) do
    j = Job.create!(title: 'Developer', industry: industry)
    j.tags << tag1
    j
  end

  let!(:other_job1) do
    j = Job.create!(title: 'Senior Developer', industry: industry)
    j.tags << tag1
    j
  end

  let!(:other_job2) do
    j = Job.create!(title: 'Junior Developer', industry: industry)
    j.tags << tag2
    j
  end

  before do
    Rails.cache.clear
  end

  describe '#find_similar' do
    context 'when all options are enabled' do
      it 'returns similar jobs filtered by title, tags, and industry' do
        service = described_class.new(job, title: true, tags: true, industry: true)
        results = service.find_similar(limit: 5)

        expect(results).to be_an(ActiveRecord::Relation)
        expect(results).to include(other_job1)
        expect(results).not_to include(job)
      end
    end

    context 'when some filters are disabled' do
      it 'applies only the enabled filters' do
        service = described_class.new(job, title: false, tags: true, industry: false)
        results = service.find_similar(limit: 5)

        expect(results).to include(other_job1)
        expect(results).not_to include(job)
      end
    end

    context 'when limit is provided' do
      it 'returns the specified number of results' do
        service = described_class.new(job, title: false, tags: false, industry: false)
        Job.create!(title: 'Another', industry: industry)

        results = service.find_similar(limit: 1)
        expect(results.size).to eq(1)
      end
    end

    context 'caching behavior' do
      it 'caches the result using cache_key' do
        service = described_class.new(job, title: true, tags: true, industry: true)

        expect(Rails.cache).to receive(:fetch).with(
          a_string_starting_with("similar_jobs/#{job.id}/"), anything
        ).and_call_original

        service.find_similar(limit: 5)
      end
    end
  end
end
