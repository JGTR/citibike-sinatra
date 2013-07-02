require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/stations.db")

class Station
  include DataMapper::Resource 
  attr_accessor :data, :address

  property  :id,             Serial
  property  :name,           String
  property  :availableDocks,  Integer
  property  :latitude,       Float
  property  :longitude,      Float
  property  :availableBikes, Integer

  def initialize(address)
    @address = address
  end

  def call
    json = File.open(@address).read
    @data = MultiJson.load(json)
    @data.each_with_index do |entry|
      station = Station.new("none")
      station.id = entry["id"]
      station.name = entry["name"]
      station.availableDocks = entry["free"]
      station.latitude = entry["lat"]/1000000.0
      station.longitude = entry["lng"]/1000000.0
      station.availableBikes = entry["bikes"]
      station.save
      p station
    end
  end

  DataMapper.finalize
  DataMapper.auto_migrate!
end