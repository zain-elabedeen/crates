require 'crates/currency_layer'
require 'date'
require 'byebug'

module Crates
  class RemoteExchangeRates
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def rates
      if options[:best]
        load_best_rates
      else
        load_rates
      end
    end

    def load_rates
      response, status = CurrencyLayer.rates(@options)
      if response['success']
        response['quotes']
      else
        response['error']
      end
    end

    def load_best_rates
      response, status = CurrencyLayer.rates(@options.merge(timeframe))
      if response['success']
        calcualte_max_rate(response['qoutes'])
      else
        response['error']
      end
    end

    def calcualte_max_rate(quotes)
      date_rate = {}, max = 0.0
      source = options[:base_currency] + options[:target_currencies]
      quotes.each do |k, v|
        if v[source] > max
          max = v[source]
          date_rate = { date: k, value: max }
        end
      end
      date_rate
    end

    def timeframe(number_of_days = 7)
      {
        start_date: Date.today.strftime('%Y-%m-%d'),
        end_date: (Date.today - number_of_days).strftime('%Y-%m-%d')
      }
    end
  end
end
