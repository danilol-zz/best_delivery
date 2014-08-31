# -*- encoding : utf-8 -*-                                                                                    |" Press <F1> for help
FactoryGirl.define do
  factory :user, class: BestDelivery::User do
    name    "Maria Antonieta Sousa"
    cpf     "75210981452"
    email   'teste@teste.com.br'
    dob     '11/03/1987'
  end

  factory :delivery_point, class: BestDelivery::DeliveryPoint do |f|
    f.description 'Distribuidor Campinas'
    f.city        'Campinas'
    f.state       'SP'
  end

  factory :highway_network, class: BestDelivery::HighwayNetwork do |f|
    f.description       'Primeira Malha'
    f.source_point       FactoryGirl.create(:delivery_point)
    f.destination_point  FactoryGirl.create(:delivery_point, description: 'Distribuidor São Paulo', city: 'São Paulo', state: 'SP')
    f.distance          10
  end
end
