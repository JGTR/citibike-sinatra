require './environment'
require File.join(File.dirname(__FILE__), 'app.rb')
source = Station.new("data/citibikenyc.json")
source.call
run Citibike::App


 
      
