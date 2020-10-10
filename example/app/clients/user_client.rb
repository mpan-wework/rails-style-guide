class UserClient < BaseClient
  def initialize
    super(baseurl: 'https://jsonplaceholder.typicode.com') # user multi-env Rails.application.credentials
  end

  def info(user_id:)
    user_id %= 10 # mod 10
    response = conn.get do |req|
      req.url "users/#{user_id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = bearer_authorization
    end

    return unless response.success?

    JSON.parse(response.body, symbolize_names: true).slice(:id, :name, :email, :phone)
  end

  def firm(user_id:)
    user_id %= 10 # mod 10
    response = conn.get do |req|
      req.url "users/#{user_id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = bearer_authorization
    end

    return unless response.success?

    # rubocop:disable Style/SingleArgumentDig
    JSON.parse(response.body, symbolize_names: true).dig(:company)
    # rubocop:enable Style/SingleArgumentDig
  end

  def posts(user_id:)
    user_id %= 10 # mod 10
    response = conn.get do |req|
      req.url "users/#{user_id}/posts"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = bearer_authorization
    end

    return unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end
end
