# -*- encoding : utf-8 -*-
class BestDelivery::App < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    rels = [
      { rel: 'user', href: '/user', type: 'application/best_delivery.user+json;charset=utf-8'},
    ]
    { best_delivery: rels }.to_json

    etag Digest::MD5.hexdigest rels.to_s

    { best_delivery: rels }.to_json
  end
end
