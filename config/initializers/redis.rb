if Rails.env.production?
  REDIS_URL = 'chubb.redistogo.com'
  REDIS_PORT = 9533
  REDIS_PASSWORD = 'efbdbca0dca7bbc447f2d9dcdfb9c6cf'
else
  REDIS_URL = 'localhost'
  REDIS_PORT = 6379
  REDIS_PASSWORD = nil
end
REDIS = Redis.new(:host => REDIS_URL, :port => REDIS_PORT, :password => REDIS_PASSWORD)
