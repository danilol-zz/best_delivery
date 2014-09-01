# -*- encoding : utf-8 -*-
class BestDelivery::Controllers::UserController < Sinatra::Base
  include HttpStatusCodes

  post '/' do
    content_type :json
    user_params = parse_json

    halt 400 if user_params.blank?

    user = BestDelivery::User.new(user_params)

    halt 409, {errors: user.errors}.to_json if user.already_exists?
    halt 400, {errors: user.errors}.to_json if user.invalid?

    user.save
    created user.href
  end

  get '/' do
    users = BestDelivery::User.all
    users.to_json
  end

  get '/:id' do
    begin
      user = BestDelivery::User.find(params[:id])
    rescue
      not_found
    end

    user.to_json
  end

  private

  POST_BODY = 'rack.input'.freeze

  def parse_json
    body = env[POST_BODY].read
    halt(400, {errors: 'Bad request. Body is blank.'}.to_json) if body.blank?
    JSON.parse body
  end
end
