# -*- encoding : utf-8 -*-
class BestDelivery::Controllers::HighwayNetworkController < Sinatra::Base
  include HttpStatusCodes

  post '/' do
    content_type :json
    highway_network_params = parse_json

    halt 400 if highway_network_params.blank?

    begin
      source      = BestDelivery::DeliveryPoint.find_by(description: highway_network_params["source_point"])
      destination = BestDelivery::DeliveryPoint.find_by(description: highway_network_params["destination_point"])
    rescue
      halt 400, {errors: "Ponto não encontrado"}.to_json
    end

    highway_network_params[:source_point] = source
    highway_network_params[:destination_point] = destination

    highway_network = BestDelivery::HighwayNetwork.new(highway_network_params)

    if highway_network.invalid?
      halt 409, {errors: highway_network.errors}.to_json if highway_network.errors[:description].include?("is already taken")
      halt 400, {errors: highway_network.errors}.to_json if highway_network.invalid?
    else
      highway_network.save
      created highway_network.id.to_s
    end
  end

  get '/' do
    BestDelivery::HighwayNetwork.all.to_json
  end

  get '/best_delivery' do
    content_type :json

    halt(400, {errors: 'Bad request. Missing Parameters.'}.to_json) unless ["source_point", "destination_point", "consumo_caminhao", "valor_litro"].all? {|attribute| params[attribute].present? }
    halt(400, {errors: 'Bad request. Invalid value.'}.to_json) unless params["consumo_caminhao"].to_i > 0

    source      = BestDelivery::DeliveryPoint.where(description: params["source_point"]).first
    destination = BestDelivery::DeliveryPoint.where(description: params["destination_point"]).first

    halt(404, {errors: 'Point not found.'}.to_json) if !source or !destination

    value = nil
    distance = 0

    origin = nil
    destiny = nil

    network = BestDelivery::HighwayNetwork.where(source_point_id: source.id, destination_point_id: destination.id).first

    if network
      origin = network.source_point
      destiny = network.destination_point
      distance = network.distance
      best_route = network.description
    else
      destiny = BestDelivery::HighwayNetwork.where(destination_point_id: destination.id).first
      mid = destiny.source_point
      sources = BestDelivery::HighwayNetwork.where(source_point_id: destiny.source_point.id).to_a
      sources.each { |s| destiny = source_point if s.source_point.description == params[:source_point] }

      point1 = BestDelivery::HighwayNetwork.where(source_point_id: source.id, destination_point_id: mid.id).first
      point2 = BestDelivery::HighwayNetwork.where(source_point_id: mid.id, destination_point_id: destination.id).first
      distance = point1.distance + point2.distance
      best_route = format_output(point1.source_point.description, point1.destination_point.description, point2.destination_point.description)
    end

    value = calculate(params[:valor_litro].to_f, params[:consumo_caminhao].to_f, distance)

    headers = { "Content-Type" => "text/html" }
    [200, headers, ["Valor Consumo R$ #{value.round(2).to_s} Melhor Rota #{best_route}"]]
  end

  private

  POST_BODY = 'rack.input'.freeze

  def parse_json
    body = env[POST_BODY].read
    halt(400, {errors: 'Bad request. Body is blank.'}.to_json) if body.blank?
    JSON.parse body
  end

  def calculate(vlr, consumo, distance)
     vlr / consumo * distance
  end

  def format_output(a, b, c)
    "#{a} -> #{b} -> #{c}"
  end
end
