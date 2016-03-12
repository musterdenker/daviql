class PreCache
  include Sidekiq::Worker
  def perform(*args)
    query_id = args.first["query_id"]
    query = Query.find query_id
    data = query.execute
    redis = Redis.new
    redis.set("query#{query.id}", {:data => data}.to_json)
    query.async_updated_at = Time.now
    query.save
  end
end