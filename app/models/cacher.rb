module Cacher
  CACHE_DURATION = 60.seconds

  #redis_key must be defined in the class that includes Cacher

    def data
      REDIS.get(redis_key)
    end

    def expire_time
      DateTime.now + CACHE_DURATION
    end

    def cache_data(raw_data)
      cacheable_data = raw_data.merge(:cache_expires => expire_time).to_json
      REDIS.set(redis_key, cacheable_data)
    end

    def cache_current?
      JSON.parse(data)["cache_expires"].to_datetime >= DateTime.now rescue false
    end

    def push_list(key, value)
      REDIS.lpush(key, value)
    end

    def pop_list(key)
      REDIS.lpop(key)
    end

    def count_list(key)
      REDIS.llen(key) || 0
    end

    def get_list(key)
      REDIS.lrange(key, 0, -1) || []
    end
  end