# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    require 'stock_quote'
    @api = StockQuote::Stock.new(api_key: 'pk_35e5597e38c64dc68c69104b80b2a88a')

    if params[:ticker] == ''
      @nothing = 'Hey! You Forgot To Enter A Symbol'
    elsif params[:ticker]
      begin
        @stock = StockQuote::Stock.quote(params[:ticker])
      rescue StandardError
        @stock = nil
        if @stock.nil?
          @error = "Hey! That Stock Symbol Doesn't Exist. Please Try Again!"
          end
      end
    end
  end

  def about; end
end
