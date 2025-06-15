class JobAnalyticService
  def initialize(job)
    @job = job
  end

  def anomalies
    anomalies = []
    recent_views = @job.views.where('created_at >= ?', 3.days.ago).count
    anomalies << { type: 'low_views', message: "This job has 0 views in the last 3 days — may be misconfigured" } if recent_views.zero?
    anomalies << { type: 'ctr_anomaly', message: 'CTR is 40% lower than similar jobs in the same category' } if ctr_anomaly?
    anomalies
  end

  private

  def ctr_anomaly?
    job_ctr = (@job.clicks || 0).to_f / [@job.views.count, 1].max
    sql = <<~SQL
      SELECT AVG(job_ctr) > 0 AND ? < (AVG(job_ctr) * 0.6) AS avg_ctr
        FROM (
          SELECT j.id,COALESCE(j.clicks, 0)::float / GREATEST(COUNT(jv.id), 1) AS job_ctr
          FROM jobs j
          LEFT JOIN job_views jv ON jv.job_id = j.id
          WHERE j.industry_id = ? AND j.id != ?
          GROUP BY j.id, j.clicks
        ) AS job_clics
    SQL
    result = ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql([sql, job_ctr, @job.industry_id, @job.id])).first
    result['avg_ctr']
  end
end
