#!/usr/bin/env ruby

# Requires Ruby 1.9.2
#
# gem install goliath

# Automatically bundle gems locally with Isolate
$: << "./lib/isolate-3.1.0.pre.3/lib"
require 'rubygems'
#require 'rubygems/user_interaction' # Required with some older RubyGems
require 'isolate/now'

require 'goliath'
require 'erb'
require 'em-synchrony/em-http'
require 'active_record'

class Log < ActiveRecord::Base
end

class HelloResponse < Goliath::API
  def response(env)
    [200, {}, "Hello World!"]
  end
end

class CountResponse < Goliath::API
  def response(env)
    log_count = Log.count
    [200, {}, log_count]
  end
end

class PersistResponse < Goliath::API
  use Goliath::Rack::Params
  def response(env)
    local_params = params
    EM.defer do
      begin
        Log.create(:type => allowed_type(local_params))
      ensure
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
    [200, {}, "ok"]
  end

  def allowed_type(params)
    if params && ["GeneralLog"].include?(params["type"])
      params["type"]
    else
      "Log"
    end
  end
end

class Receiver < Goliath::API
  map '/api/hello', HelloResponse
  map '/api/count', CountResponse
  map '/api/log', PersistResponse
end