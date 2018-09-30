class HomeController < ApplicationController
  def index
    response= ::CoinMarketService::CoinMarketCap.new().latest_currency_list
    @response = JSON.parse(response.body)
  end
end
