task clean_requests: :environment do
  # retention_period = 3.days.ago

  # Request.delete_all  created_at: { '$lt' => retention_period }
  # Response.delete_all created_at: { '$lt' => retention_period }
  #
  # Not needed ^^^ anymore, it's using Mongo TTL 604800 = 7 days
  # db.requests.ensureIndex({ "created_at": 1 }, { expireAfterSeconds: 604800 })
  # db.responses.ensureIndex({ "created_at": 1 }, { expireAfterSeconds: 604800 })
end

task :clean_buckets => :environment do
  retention_period = 3.months.ago

  Bucket.delete_all(last_request_at: { '$lt' => retention_period }, updated_at:  { '$lt' => retention_period } )

  Bucket.delete_all(last_request_at: nil, updated_at:  { '$lt' => retention_period } )
end
