require 'sinatra/base'
require 'elasticsearch'
require 'redis'

class RubyAPI < Sinatra::Base
  f = File.open("/tmp/rubyapp.log", 'a')
  f.sync = true
  logger = Logger.new(f)
  logger.level = Logger::DEBUG
  set :logger, logger

  get '/' do
    val = params['val'].to_i || 1
    lv = params['lv']
    lv = 'debug' unless !(lv.nil? || lv.empty?) && ['warn', 'error', 'info', 'debug'].include?(lv)

    logger.send(lv, "Hello world val = #{val}")

    "Hello World! #{lv}:#{val}"
  end

  get '/es' do
    client = Elasticsearch::Client.new url: 'https://es:9200', transport_options: { ssl: { verify: false } }

    "ES result: #{client.cluster.health}"
  end

  get '/redis' do
    redis = Redis.new(host: "redis", port: 6379)

    redis.get("hoge")
  end

end
