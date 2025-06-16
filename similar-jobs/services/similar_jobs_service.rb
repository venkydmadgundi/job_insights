class SimilarJobsService
  def initialize(job, options = {})
    @job = job
    @options = options
  end

  def find_similar(limit: 5)
    # Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      base_scope = Job.where.not(id: @job.id)
      base_scope = base_scope.with_similar_title(@job.title) if @options[:title]
      base_scope = base_scope.with_tags(@job.tag_ids) if @options[:tags]
      base_scope = base_scope.in_industry(@job.industry_id) if @options[:industry]
      base_scope.limit(limit)
    # end
  end

  private

  def cache_key
    "similar_jobs/#{@job.id}/#{@job.updated_at.to_i}"
  end
end
