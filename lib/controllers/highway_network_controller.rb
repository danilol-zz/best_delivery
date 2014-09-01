# -*- encoding : utf-8 -*-
class BestDelivery::Controllers::HighwayNetworkController < Sinatra::Base
  include HttpStatusCodes

  post '/' do
    puts "HELLOWORLD"
  end

  POST_BODY = 'rack.input'.freeze

  def parse_json
    body = env[POST_BODY].read
    halt(400, {errors: 'Bad request. Body is blank.'}.to_json) if body.blank?
    JSON.parse body
  end
end
