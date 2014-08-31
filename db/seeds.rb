# -*- encoding : utf-8 -*-
a = BestDelivery::DeliveryPoint.create(description: "São José do Rio Preto", city: "São José do Rio Preto", state: "SP")
b = BestDelivery::DeliveryPoint.create(description: "Ribeirão Preto",        city: "Ribeirão Preto",        state: "SP")
c = BestDelivery::DeliveryPoint.create(description: "Araraquara",            city: "Araraquara",            state: "SP")
d = BestDelivery::DeliveryPoint.create(description: "Lins",                  city: "Lins",                  state: "SP")
e = BestDelivery::DeliveryPoint.create(description: "Araçatuba",             city: "Araçatuba",             state: "SP")

### Mapa 1 - Interior SP
puts "Creating Mapa 1"
BestDelivery::HighwayNetwork.create(description: "A -> B", source_point: a, destination_point: b, distance: 207)
BestDelivery::HighwayNetwork.create(description: "B -> D", source_point: a, destination_point: b, distance: 238)
BestDelivery::HighwayNetwork.create(description: "A -> C", source_point: a, destination_point: b, distance: 170)
BestDelivery::HighwayNetwork.create(description: "C -> D", source_point: a, destination_point: b, distance: 201)
BestDelivery::HighwayNetwork.create(description: "B -> E", source_point: a, destination_point: b, distance: 327)
BestDelivery::HighwayNetwork.create(description: "D -> E", source_point: a, destination_point: b, distance: 94)

#locais
a = BestDelivery::DeliveryPoint.create(description: "Brasília",       city: "Brasília",       state: "DF")
b = BestDelivery::DeliveryPoint.create(description: "Belo Horizonte", city: "Belo Horizonte", state: "MG")
c = BestDelivery::DeliveryPoint.create(description: "Rio de Janeiro", city: "Rio de Janeiro", state: "RJ")
d = BestDelivery::DeliveryPoint.create(description: "São Paulo",      city: "São Paulo",      state: "SP")
e = BestDelivery::DeliveryPoint.create(description: "Goiânia",        city: "Goiânia",        state: "GO")

### Mapa 2 - Centro Brasil
puts "Creating Mapa 2"
BestDelivery::HighwayNetwork.create(description: "A -> B", source_point: a, destination_point: b, distance: 736)
BestDelivery::HighwayNetwork.create(description: "B -> D", source_point: a, destination_point: b, distance: 585)
BestDelivery::HighwayNetwork.create(description: "A -> C", source_point: a, destination_point: b, distance: 1162)
BestDelivery::HighwayNetwork.create(description: "C -> D", source_point: a, destination_point: b, distance: 432)
BestDelivery::HighwayNetwork.create(description: "B -> E", source_point: a, destination_point: b, distance: 873)
BestDelivery::HighwayNetwork.create(description: "D -> E", source_point: a, destination_point: b, distance: 929)

#locais
a = BestDelivery::DeliveryPoint.create(description: "Fortaleza", city: "Fortaleza", state: "CE")
b = BestDelivery::DeliveryPoint.create(description: "Natal",     city: "Natal",     state: "RN")
c = BestDelivery::DeliveryPoint.create(description: "Recife",    city: "Recife",    state: "PE")
d = BestDelivery::DeliveryPoint.create(description: "Petrolina", city: "Petrolina", state: "PE")
e = BestDelivery::DeliveryPoint.create(description: "Teresina",  city: "Teresina",  state: "PI")

### Mapa 3 - Nordeste
puts "Creating Mapa 3"
BestDelivery::HighwayNetwork.create(description: "A -> B", source_point: a, destination_point: b, distance: 522)
BestDelivery::HighwayNetwork.create(description: "B -> D", source_point: a, destination_point: b, distance: 858)
BestDelivery::HighwayNetwork.create(description: "A -> C", source_point: a, destination_point: b, distance: 754)
BestDelivery::HighwayNetwork.create(description: "C -> D", source_point: a, destination_point: b, distance: 714)
BestDelivery::HighwayNetwork.create(description: "B -> E", source_point: a, destination_point: b, distance: 1027)
BestDelivery::HighwayNetwork.create(description: "D -> E", source_point: a, destination_point: b, distance: 635)

