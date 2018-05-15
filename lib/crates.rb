require 'crates/version'
require 'crates/remote_exchange_rates'

module Crates
  def self.exchange_rates(options)
    r = RemoteExchangeRates.new(options)
    response = r.rates
  end
end
