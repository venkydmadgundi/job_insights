# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Industries
it_industry = Industry.create!(name: "Information Technology")
finance_industry = Industry.create!(name: "Finance")
manufacture_industry = Industry.create!(name: "Manufacture")
bank_industry = Industry.create!(name: "Bank")

# Tags
remote_tag = Tag.create!(name: "Remote")
hybrid_tag = Tag.create!(name: "Hybrid")
fulltime_tag = Tag.create!(name: "Full-time")
halftime_tag = Tag.create!(name: "Half-time")
junior_tag = Tag.create!(name: "Junior")
senior_tag = Tag.create!(name: "Senior")
trainee_tag = Tag.create!(name: "Trainee")

# Jobs
job1 = Job.create!(
  title: "Junior Ruby Developer",
  description: "Write and maintain Ruby on Rails applications.",
  industry: it_industry,
  clicks: 10,
  applied: 5
)
job2 = Job.create!(
  title: "Senior Ruby Engineer",
  description: "Lead Ruby projects and mentor juniors.",
  industry: it_industry,
  clicks: 10,
  applied: 7
)
job3 = Job.create!(
  title: "Network Administrator",
  description: "Maintains and troubleshoots network infrastructure.",
  industry: it_industry,
  clicks: 10,
  applied: 8
)

job4 = Job.create!(
  title: "Database Administrator",
  description: "Manages and maintains databases.",
  industry: it_industry,
  clicks: 1,
  applied: 1
)

job5 = Job.create!(
  title: "Finance Operations Associate",
  description: "Support financial operations and reporting.",
  industry: finance_industry,
  clicks: 2,
  applied: 5
)

job6 = Job.create!(
  title: "Investment Manager",
  description: "Manages investment portfolios for individuals or institutions",
  industry: finance_industry,
  clicks: 1,
  applied: 6
)

job7 = Job.create!(
  title: "Branch Manager",
  description: "Oversees the operations of a specific bank branch.",
  industry: bank_industry,
  clicks: 12,
  applied: 15
)

job8 = Job.create!(
  title: "Customer Relationship Manager",
  description: "Builds and maintains relationships with bank clients.",
  industry: bank_industry,
  clicks: 1,
  applied: 10
)

job9 = Job.create!(
  title: "Quality control and testing",
  description: "Ensuring the product meets quality standards.",
  industry: manufacture_industry,
  clicks: 2,
  applied: 5
)

job10 = Job.create!(
  title: "Production Manager",
  description: "Oversees the entire production process.",
  industry: manufacture_industry,
  clicks: 1,
  applied: 7
)

# Job Tags
job1.tags << [ remote_tag, fulltime_tag, junior_tag ]
job2.tags << [ remote_tag, fulltime_tag, senior_tag ]
job3.tags << [ fulltime_tag ]
job4.tags << [ fulltime_tag, junior_tag ]
job5.tags << [ hybrid_tag ]
job6.tags << [ halftime_tag, hybrid_tag ]
job7.tags << [ remote_tag, fulltime_tag, halftime_tag ]
job8.tags << [ trainee_tag, fulltime_tag ]
job9.tags << [ remote_tag, hybrid_tag ]
job10.tags << [ halftime_tag, trainee_tag ]

# Job Views
[ job1, job2, job3 ].each do |job|
  JobView.create!(job: job, created_at: 1.day.ago)
end

5.times do
  JobView.create!(job: job4, created_at: 5.days.ago)
end

[ job5, job6, job7, job8, job9, job10 ].each do |job|
  5.times do
    JobView.create!(job: job, created_at: rand(1..7).days.ago)
  end
end
