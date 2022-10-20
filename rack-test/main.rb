require './main.rb'  # <-- your sinatra app
require 'test/unit'
require 'rack/test'

class MainTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RubyAPI
  end

  def test_root
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World!', last_response.body
  end

  def test_es
    get '/es'
    assert !last_response.ok?
    # assert_equal 'Hello es', last_response.body
  end
end

