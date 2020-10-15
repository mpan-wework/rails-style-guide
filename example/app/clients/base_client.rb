class BaseClient
  class GraphqlQueryError < ::StandardError; end

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

  def graphql_query(query:, variables: {}, url: 'graphql', headers: {})
    headers = { 'Content-Type': 'application/json' }.merge headers
    response = conn.post do |req|
      req.url url
      req.body = { query: query, variables: variables }.to_json
      headers.each { |header, content| req.headers[header] = content }
    end

    raise GraphqlQueryError, response.body unless response.success?

    parse_response response
  end

  def parse_response(response)
    JSON.parse(response.body).deep_transform_keys(&:underscore).deep_symbolize_keys
  end
end
