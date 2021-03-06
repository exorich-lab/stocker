# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :set_stock, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  # GET /stocksß
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  def check_symbol(ticker)
    symbol = StockQuote::Stock.quote(ticker)
    unless symbol.nil?
      true
    end
  rescue StandardError
    false
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show; end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit; end

  # POST /stocks
  # POST /stocks.json
  def create
    if check_symbol(stock_params[:ticker])

      @stock = Stock.new(stock_params)

      respond_to do |format|

        if @stock.save
          format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
          format.json { render :show, status: :created, location: @stock }
        else
          format.html { render :new }
          format.json { render json: @stock.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_stock_path, notice: "Hey! That Stock Symbol Doesn't Exist. Please Try Again!"
    end
    end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    if check_symbol(stock_params[:ticker])
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to @stock, notice: "Hey! That Stock Symbol Doesn't Exist. Please Try Again!"
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @ticker = current_user.stocks.find_by(id: params[:id])
    if @ticker.nil?
      redirect_to stocks_path, notice: 'Not Authorized to edit this stock'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    @stock = Stock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit(:ticker, :user_id)
  end
end
