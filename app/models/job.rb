class Job < ApplicationRecord
  has_many :views, class_name: "JobView"
  belongs_to :industry
  validates :title, presence: true, uniqueness: {scope: :industry_id}
end
