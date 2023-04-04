# frozen_string_literal: true

require 'faraday'

module AfricasTalking
  class SmsClient # rubocop:disable Style/Documentation
    attr_reader :phone, :message

    def initialize(phone, message)
      @phone = phone
      @message = message
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = 'https://api.africastalking.com/version1/'
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.headers['apiKey'] = Rails.application.credentials.africas_talking.fetch(:api_key)
        conn.adapter :net_http
      end
    end

    def body # rubocop:disable Metrics/AbcSize
      Faraday::Utils::ParamsHash.new.tap do |b|
        b[:username] = Rails.application.credentials.africas_talking.fetch(:username)
        b[:to] = phone.join(',')
        b[:message] = message
        b[:from] = Rails.application.credentials.africas_talking.fetch(:short_code)
      end
    end

    def send
      connection.post('messaging', body.to_query, { 'Content-Type': 'application/x-www-form-urlencoded' })
    end
  end
end
