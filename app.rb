require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application

    before do
        source = Station.new("data/citibikenyc.json")
        source.call
    end

    get '/' do
      @stations = Station.all
      erb :home, :layout => true
    end

    get '/form' do
      @data
      erb :form, :layout => true
    end

    post '/map' do
      @start = params["start"]
      @end = params["end"]
      # @startlat = @start.split(",")[1].to_i/1000000.0
      # @startlng = @start.split(",")[2].to_i/1000000.0
      # @endlat = @end.split(",")[1].to_i/1000000.0
      # @endlng = @end.split(",")[2].to_i/1000000.0
      erb :map, :layout => true
    end

    get '/stations/new' do
      @station = Station.new("none")
      erb :new, :layout => true
    end

    post '/stations/create' do
      @station = Station.new("none")
      @station.name = params[:name]
      @station.latitude = params[:latitude]
      @station.longitude = params[:longitude]
      @station.availableBikes = params[:availableBikes]
      @station.availableDocks = params[:availableDocks]
      @station.save
      erb :show, :layout => true
    end

    get '/stations/:id' do
      @station = Station.all[(params[:id].to_i - 1)]
      erb :show, :layout => true
    end

    get '/stations/:id/edit' do
      @station = Station.all[(params[:id].to_i - 1)]
      erb :edit, :layout => true
    end

    post '/stations/:id/update' do
      @station = Station.all[(params[:id].to_i - 1)]
      @station.name = params[:name]
      @station.latitude = params[:latitude]
      @station.longitude = params[:longitude]
      @station.availableBikes = params[:availableBikes]
      @station.availableDocks = params[:availableDocks]
      @station.save
      erb :show, :layout => true
    end

    get '/stations/:id/delete' do
      erb :delete, :layout => true
    end
  end
end


 # @start = params[:start].split(",").slice(1,2).collect{|x| x.to_i/1000000.0}
 #      @end = params[:end].split(",").slice(1,2).collect{|x| x.to_i/1000000.0}