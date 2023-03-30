require 'sinatra/base'
require 'elasticsearch'
require 'redis'


class RubyAPI < Sinatra::Base

  get '/' do
    "Hello World!"
  end

  get '/es' do
    client = Elasticsearch::Client.new url: 'https://es:9200'

    "ES result: #{client.cluster.health}"
  end

  get '/redis' do
    redis = Redis.new(host: "redis", port: 6379)

    redis.get("hoge")
  end

end
