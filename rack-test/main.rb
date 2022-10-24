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
    sleep 10
    if (rand(0..9) < 7)
      assert !last_response.ok?
    else
      sleep 5
      assert last_response.ok?
    end
    # assert_equal 'Hello es', last_response.body
  end
end

