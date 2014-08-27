# -*- encoding : utf-8 -*-
require 'bundler'
Bundler.require

$: << File.dirname(__FILE__)
require 'best_delivery'

run Rack::URLMap.new BestDelivery.route_map
