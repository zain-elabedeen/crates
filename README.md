# Crates

The app connect to currency layer API and return exchange rates base on options 

## Run (development enviroment)
 The CLI is build using thor Gem, run using bundle
 
 bundle exec bin/crates send_rates

## Usage
 for help run    
    bundle exec bin/crates help send_rates

 get rates againest multiple currencies
    bundle exec bin/crates send_rates --base-currency="USD" --target-currencies="EUR","GBP"
  
 get best rates in the last 7 days
     bundle exec bin/crates send_rates -b --base-currency="USD" --target-currencies="EUR"

## TODOs
    - send rates to slack or sms(twilio)
    - add tests
    - enhance options parsing and validation
    - move faraday configuration to a new connection class
    - Gem build and install configuration
