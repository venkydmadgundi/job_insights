class Job < ApplicationRecord
  has_many :views, class_name: "JobView"
  has_many :job_tags
  has_many :tags, through: :job_tags
  belongs_to :industry

  scope :with_tags, ->(tag_ids) {
    joins(:tags).where(tags: { id: tag_ids }).distinct
  }
  scope :with_similar_title, ->(title) {
    terms = title.to_s.split(/\s+/).map { |term| "%#{term}%" }
    where(terms.map { "title LIKE ?" }.join(" OR "), *terms).distinct
  }

  scope :in_industry, ->(industry_id) {
    where(industry_id: industry_id).distinct
  }
end
