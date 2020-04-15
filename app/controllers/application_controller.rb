# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require 'stock_quote'
  @api = StockQuote::Stock.new(api_key: 'pk_35e5597e38c64dc68c69104b80b2a88a')
end
