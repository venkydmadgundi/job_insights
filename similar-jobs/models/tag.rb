class Tag < ApplicationRecord
  has_many :job_tags
  has_many :jobs, through: :job_tags
  validates :name, presence: true,  uniqueness: true
end
