require 'sinatra/base'
require 'elasticsearch'
require 'redis'
require 'logger'

class RubyAPI < Sinatra::Base
  f = File.open("/tmp/rubyapp.log", 'a')
  f.sync = true
  logger = Logger.new(f)
  logger.level = Logger::DEBUG
  logger.formatter = proc{|severity, datetime, progname, message|
    date_format = datetime.utc.iso8601(3)
    "#{date_format} #{severity} #{message}\n"
  }
  set :logger, logger

  get '/' do
    val = params['val']
    lv = params['lv']
    if lv.nil? && val.nil?
      logger.send('warn', "Warning: missing params")
      return "Hello World!"
    else
      val = val.to_i || 1
      lv = 'debug' unless ['warn', 'error', 'info', 'debug'].include?(lv)
      logger.send(lv, "Hello world val = #{val}")
      return "Hello World! #{lv}:#{val}"
    end

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
