class BaseClient
  def initialize(baseurl:, token: '')
    @baseurl = baseurl
    @token = token
  end

  private

  def conn
    @conn ||= Faraday.new(url: @baseurl) do |f|
      f.request :url_encoded
      f.response :logger, Rails.logger, bodies: true
      f.adapter Faraday.default_adapter
    end
  end

  def bearer_authorization
    "Bearer #{@token}"
  end
end
