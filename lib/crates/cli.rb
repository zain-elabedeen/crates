require 'crates'
require 'thor'

module Crates
  class CLI < Thor
    desc 'get_rates', 'load rates'

    method_option :base_currency, default: 'USD'
    method_option :target_currencies, default: 'GBP'
    method_option :best, type: :boolean, aliases: '-b'
    method_option :amount
    method_option :date

    def send_rates
      Crates.exchange_rates(options)
    end
  end
end
