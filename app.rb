require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application

    get '/' do
      @stations = Station.all
      erb :home
    end

    get '/form' do
      @data
      erb :form
    end

    post '/map' do
      @start = params["start"]
      @end = params["end"]
      # @startlat = @start.split(",")[1].to_i/1000000.0
      # @startlng = @start.split(",")[2].to_i/1000000.0
      # @endlat = @end.split(",")[1].to_i/1000000.0
      # @endlng = @end.split(",")[2].to_i/1000000.0
      erb :map
    end

    get '/stations/new' do
      @station = Station.new("none")
      erb :new
    end

    post '/stations/create' do

      erb :create
    end

    get '/stations/:id' do
      @station = Station.all[(params[:id].to_i - 1)]
      erb :show
    end

    get '/stations/:id/edit' do
      erb :edit
    end

    get '/stations/:id/delete' do
      erb :delete
    end
  end
end


 # @start = params[:start].split(",").slice(1,2).collect{|x| x.to_i/1000000.0}
 #      @end = params[:end].split(",").slice(1,2).collect{|x| x.to_i/1000000.0}