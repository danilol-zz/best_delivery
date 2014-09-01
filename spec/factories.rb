# -*- encoding : utf-8 -*-                                                                                    |" Press <F1> for help
FactoryGirl.define do
  factory :user, class: BestDelivery::User do
    _id        '5404af3c8ae0047a32000003'
    name       'Maria Antonieta Sousa'
    cpf        '75210981452'
    email      'teste@teste.com.br'
    dob        '11/03/1987'
    created_at DateTime.parse('2012/06/06 11:11:11')
    updated_at DateTime.parse('2012/06/06 12:11:11')
  end

  factory :delivery_point, class: BestDelivery::DeliveryPoint do |f|
    f.description 'Distribuidor Campinas'
    f.city        'Campinas'
    f.state       'SP'
  end

  factory :highway_network, class: BestDelivery::HighwayNetwork do |f|
    f.description       'Primeira Malha'
    f.source_point       { FactoryGirl.create(:delivery_point) }
    f.destination_point  { FactoryGirl.create(:delivery_point, description: 'Distribuidor São Paulo', city: 'São Paulo', state: 'SP') }
    f.distance          10
  end
end
