require 'faraday'
require 'faraday_middleware'

module Crates
  module CurrencyLayer
    ACCESS_KEY = ENV['CURRENCYLAYER_ACCESS_KEY']
    BASE_URL = 'http://apilayer.net/api/'
    END_POINTS = { live: 'live', convert: 'convert', historical: 'historical', timeframe: 'timeframe' }

    class << self
      def rates(options = {})
        request(request_params(options))
      end

      def request(request_params)
        end_point = end_point_from_options(request_params)
        response = get(end_point, request_params)
        parse_response(response)
      end

      def parse_response(response)
        response.status == 200 ? success(response) : errors(response)
      end

      def success(response)
        [response.body, response.status]
      end

      def errors(response)
        error = { errors: { status: response['status'], message: response['message'] } }
        response.merge(error)
      end

      def get(end_point, request_params)
        connection.get end_point, request_params
      end

      def connection
        Faraday.new(url: BASE_URL) do |faraday|
          faraday.response :json
          faraday.adapter Faraday.default_adapter
          faraday.headers['Content-Type'] = 'application/json'
        end
      end

      def end_point_from_options(options)
        if options[:start_date] && options[:end_date]
          END_POINTS[:timeframe]
        elsif options[:amount]
          END_POINTS[:convert]
        elsif options[:date]
          END_POINTS[:historical]
        else
          END_POINTS[:live]
        end
      end

      private

      def request_params(options = {})
        {
          access_key: ACCESS_KEY,
          source: options[:base_currency],
          currencies: options[:target_currencies],
          date: options[:date],
          amount: options[:amount],
          start_date: options[:start_date],
          end_date: options[:end_date]
        }.delete_if { |_k, v| v.nil? }
      end
    end
  end
end
