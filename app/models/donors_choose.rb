module DonorsChoose
  def self.api_key=(key)
      @api_key = key
    end

    def self.api_key
      @api_key ||= "DONORSCHOOSE"
    end

  class Client
    DC_API = 'http://api.donorschoose.org/common/json_feed.html'
    def initialize options={}
      options[:url] ||= DC_API
      @conn = Faraday.new(url: options[:url])
    end

    def get_projects params={}
      params.merge(APIKey: DonorsChoose.api_key)
      resp = @conn.get do |req|
        puts params.inspect
        params.each do |key, value|
          req.params[key] = value
        end
      end
    end
  end
end