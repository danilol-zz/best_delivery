# -*- encoding : utf-8 -*-
module BestDelivery
  class << self
    attr_accessor :config

    def configure
      Mongoid.load!("#{File.dirname(__FILE__)}/mongoid.yml")
    end
  end
end


BestDelivery.configure
