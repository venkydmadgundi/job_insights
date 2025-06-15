# ./similar-jobs/Dockerfile
FROM base AS similarity

ENV SERVICE_NAME=similarity
EXPOSE 3001

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
