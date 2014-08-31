# -*- encoding : utf-8 -*-
class BestDelivery::HighwayNetwork
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description,       type: String
  field :source_point,      type: String
  field :destination_point, type: String
  field :distance,          type: Integer

  index(description: 1)

  validates :description,  uniqueness: true, presence: true, length:  { maximum: 100 }
  validates :source_point,                   presence: true
  validates :destination_point,              presence: true
  validates_numericality_of :distance,   only_integer: true, presence: true

  validate  :delivery_point

  belongs_to :source_point,      class_name: "BestDelivery::DeliveryPoint"
  belongs_to :destination_point, class_name: "BestDelivery::DeliveryPoint"

  private

  def delivery_point
    point = BestDelivery::DeliveryPoint.where(description: source_point.description).first
    self.errors.add(:source_point, "Origem não cadastrada!!") unless point

    point = BestDelivery::DeliveryPoint.where(description: destination_point.description).first
    self.errors.add(:destination_point, "Destino não cadastrado!!") unless point
  end
end
