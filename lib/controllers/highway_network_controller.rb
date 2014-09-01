# -*- encoding : utf-8 -*-
class BestDelivery::Controllers::HighwayNetworkController < Sinatra::Base
  include HttpStatusCodes

  post '/' do
    content_type :json
    highway_network_params = parse_json

    halt 400 if highway_network_params.blank?

    highway_network = BestDelivery::HighwayNetwork.new(highway_network_params)

    halt 400, {errors: highway_network.errors}.to_json if highway_network.invalid?
  end

  POST_BODY = 'rack.input'.freeze

  def parse_json
    body = env[POST_BODY].read
    halt(400, {errors: 'Bad request. Body is blank.'}.to_json) if body.blank?
    JSON.parse body
  end
end
