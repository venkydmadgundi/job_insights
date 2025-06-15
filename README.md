# Job Insights & Similar Jobs Microservice

A lightweight, scalable Ruby on Rails microservice that provides:
- **Job performance insights** based on engagement metrics
- **Content-based similar job recommendations**
- Designed with microservice architecture, containerized using Docker

---

## 🚀 Features

- Detect underperforming job listings based on views & click-through rate (CTR)
- Recommend similar jobs based on title, tags, and industry
- RESTful API with JSON responses
- PostgreSQL database
- RSpec & FactoryBot for test coverage
- Docker-ready for easy deployment

---

## 🛠️ Setup Instructions

### Prerequisites

- Ruby 3.x
- Rails 7.x
- PostgreSQL
- Docker & Docker Compose

## API Endpoints
| Method | Endpoint                     | Description                       |
| ------ | ---------------------------- | --------------------------------- |
| GET    | `/api/v1/jobs/:id/similar`   | Fetch similar jobs                |
| GET    | `/api/v1/jobs/:id/insights`  | Analyze job performance anomalies |


## Microservices
**Insights**
- Analyzes job listings for anomalies
- Metrics: views over 3 days, CTR comparison to peers
- Endpoint: /api/v1/jobs/:id/insights

**Similarity**
- Returns content-based similar job recommendations
- Filters by title, tags, industry
- Endpoint: /api/v1/jobs/:id/similar

### Local Setup and Rspec

```bash
git clone https://github.com/your-org/job-insights-service.git
cd job-insights-service

# Build and start Docker containers
docker-compose build
docker-compose up -d

# Set up DB and run specs for 'similarity' microservice
docker-compose run similarity bash
bash:/app# rails db:create db:migrate db:seed
bash:/app# rspec
bash:/app# exit

# Run specs for 'insights' microservice
docker-compose run insights bash
bash:/app# rspec
bash:/app# exit

