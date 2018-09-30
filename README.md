# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version : 2.5.1
* Rails version : 5.2


# Initial setup

* clone repository
* bundle install
* copy secrets.yml 
  cp config/secrets.yml secrets.yml
* Config credential in secrets.yml

# Google API Setup

* Go to 'https://console.developers.google.com'
* Select your project.
* Click 'Enable and manage APIs'.
* Make sure "Contacts API" and "Google+ API" are on.
* Go to Credentials, then select the "OAuth consent screen" tab on top, and provide an 'EMAIL ADDRESS' and a 'PRODUCT NAME'
* Wait 10 minutes for changes to take effect.

# CoinMarketCap  API

* Go to 'https://coinmarketcap.com/' and create account and copy api key


# start server
* rails server
