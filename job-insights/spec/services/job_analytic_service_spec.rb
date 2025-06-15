require 'rails_helper'

describe JobAnalyticService do
  let(:industry) { Industry.find_or_create_by!(name: "Information Technology") }
  let(:job) { Job.create!(title: "Developer", industry: industry, clicks: 5) }

  describe '#anomalies' do
    subject { described_class.new(job) }

    context 'when there are no views in the last 3 days' do
      it 'adds a low_views anomaly' do
        JobView.create!(job: job, created_at: 4.days.ago)

        allow(subject).to receive(:ctr_anomaly?).and_return(false)

        anomalies = subject.anomalies
        expect(anomalies).to include(
          a_hash_including(type: 'low_views')
        )
      end
    end

    context 'when there are recent views' do
      it 'does not add a low_views anomaly' do
        JobView.create!(job: job, created_at: 2.days.ago)

        allow(subject).to receive(:ctr_anomaly?).and_return(false)

        anomalies = subject.anomalies
        expect(anomalies).not_to include(a_hash_including(type: 'low_views'))
      end
    end

    context 'when ctr_anomaly? is true' do
      it 'adds a ctr_anomaly' do
        allow(subject).to receive(:ctr_anomaly?).and_return(true)

        anomalies = subject.anomalies
        expect(anomalies).to include(
          a_hash_including(type: 'ctr_anomaly')
        )
      end
    end

    context 'when ctr_anomaly? is false' do
      it 'does not add a ctr_anomaly' do
        allow(subject).to receive(:ctr_anomaly?).and_return(false)

        anomalies = subject.anomalies
        expect(anomalies).not_to include(a_hash_including(type: 'ctr_anomaly'))
      end
    end
  end

  describe '#ctr_anomaly?' do
    subject { described_class.new(job) }

    before do
      Job.create!(title: "Other Job", industry: industry, clicks: 10).tap do |j|
        10.times { JobView.create!(job: j) }
      end
    end

    it 'returns true if job CTR is 40% lower than avg' do
      allow(ActiveRecord::Base.connection).to receive(:execute).and_return([{ 'avg_ctr' => true }])

      expect(subject.send(:ctr_anomaly?)).to eq(true)
    end

    it 'returns false if job CTR is not 40% lower than avg' do
      allow(ActiveRecord::Base.connection).to receive(:execute).and_return([{ 'avg_ctr' => false }])

      expect(subject.send(:ctr_anomaly?)).to eq(false)
    end
  end
end
