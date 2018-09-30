module CoinMarketService
  class CoinMarketCap
    include HTTParty
    base_uri 'https://pro-api.coinmarketcap.com/v1/'

    def initialize(search="market_cap", limit=10)
      @options = {query: {
                    sort: search, limit: limit},
                  headers:  {
                    'X-CMC_PRO_API_KEY': Rails.application.secrets.coin_market_cap_key}
                  }
    end

    def latest_currency_list
      self.class.get("/cryptocurrency/listings/latest",@options)
    end
  end
end
