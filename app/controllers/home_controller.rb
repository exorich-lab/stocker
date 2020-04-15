# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if params[:ticker] == ''
      flash[:forgotsymbol] = 'Hey! You Forgot To Enter A Symbol'
    elsif params[:ticker]
      begin
        @stock = StockQuote::Stock.quote(params[:ticker])
      rescue StandardError
        @stock = nil
        if @stock.nil?
          flash[:forgotsymbol] = "Hey! That Stock Symbol Doesn't Exist. Please Try Again!"
          end
      end
    end
  end

  def about; end
end
