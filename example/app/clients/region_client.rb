# frozen_string_literal: true

module RegionClientQuery; end

class RegionClient < BaseClient
  include RegionClientQuery

  SUPPORTED_REGION_CODES = %w(CN GB HK JP KR MO RU TW US).freeze

  def initialize
    super(baseurl: 'https://countries.trevorblades.com') # user multi-env Rails.application.credentials
  end

  def regions
    graphql_query(
      query: regions_query,
      variables: { regionCodes: SUPPORTED_REGION_CODES },
      headers: { Authorization: bearer_authorization }
    )&.dig(:data, :regions)
  end

  def region(code:)
    graphql_query(
      query: region_query,
      variables: { code: code.to_s.slice(0, 2).upcase },
      headers: { Authorization: bearer_authorization }
    )&.dig(:data, :region)
  end
end

module RegionClientQuery
  REGION_ATTRS = 'code name capital phone currency native'
  LANGUAGES_ATTRS = 'name native'

  private

  def regions_query
    <<~QUERY
      query($regionCodes: [String]) {
        regions: countries(filter: { code: { in: $regionCodes }}) {
          #{REGION_ATTRS}
          languages {
            #{LANGUAGES_ATTRS}
          }
        }
      }
    QUERY
  end

  def region_query
    <<~QUERY
      query($code: ID!) {
        region: country(code: $code) {
          #{REGION_ATTRS}
          languages {
            #{LANGUAGES_ATTRS}
          }
        }
      }
    QUERY
  end
end
