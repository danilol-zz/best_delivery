# -*- encoding : utf-8 -*-
class BestDelivery::DeliveryPoint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description,  type: String
  field :city,         type: String
  field :state,        type: String

  index(description: 1)

  validates :description,  uniqueness: true, presence: true, length:  { maximum: 100 }
  validates :city,                           presence: true, length:  { maximum:  50 }
  validates :state,                          presence: true, length:  { maximum:  20 }
end
