# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BestDelivery::Controllers::HighwayNetworkController do
  subject { last_response }

  context 'create' do
    context 'failure' do
      context 'validation error' do
        context 'fail when no params was sent' do
          before { post '/highway_network' }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":\"Bad request. Body is blank.\"}" }
        end

        context 'fails when a required field was not sent' do
          let(:source)      { FactoryGirl.create(:delivery_point) }
          let(:destination) { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }

          let(:highway_network_params) { { source_point: source.description, destination_point: destination.description, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"description\":[\"can't be blank\"]}}" }
        end

        context 'fails when a required field was sent with nil value' do
          let(:source)      { FactoryGirl.create(:delivery_point) }
          let(:destination) { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }

          let(:highway_network_params) { { description: nil, source_point: source.description, destination_point: destination.description, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"description\":[\"can't be blank\"]}}" }
        end

        context 'fails when a point field was sent with invalid value' do
          let(:source)      { FactoryGirl.create(:delivery_point) }
          let(:destination) { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }

          let(:highway_network_params) { { description: 'test', source_point: "teste", destination_point: destination.description, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":\"Ponto não encontrado\"}" }
        end

        context 'conflict' do
          let(:source)          { FactoryGirl.create(:delivery_point) }
          let(:destination)     { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }
          let(:highway_network_params) { { description: 'Primeira Malha', source_point: source.description, destination_point: destination.description, distance: 10 } }

          before do
            highway_network = FactoryGirl.create(:highway_network, source_point: source, destination_point: destination)
            post '/highway_network', highway_network_params.to_json
          end

          its(:status) { should eq 409 }
          its(:body)   { should eq "{\"errors\":{\"description\":[\"is already taken\"]}}" }
        end
      end
    end

    context 'success' do
      let(:source)          { FactoryGirl.create(:delivery_point) }
      let(:destination)     { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }
      let(:highway_network_params) { { description: 'Primeira Malha', source_point: source.description, destination_point: destination.description, distance: 10 } }

      before { post '/highway_network', highway_network_params.to_json }

      its(:status) { should eq 201 }
      its(:body)   { should eq "" }
    end
  end

  describe 'GET highway_network list' do
    context 'non-existing' do
      before { BestDelivery::HighwayNetwork.should_receive(:all).and_return([]) }

      it 'returns an empty array' do
        get "/highway_network"
        expect(last_response).to be_ok
        expect(last_response.body).to eq "[]"
      end
    end

    context 'existing highway_network' do
      let(:highway_network) { FactoryGirl.create(:highway_network) }

      before { BestDelivery::HighwayNetwork.should_receive(:all).and_return([highway_network]) }
      it 'returns the JSON resource of that highway_network' do
        get "/highway_network"

        last_response.should be_ok

        result = JSON.parse(last_response.body).first
        expect(result["description"]).to eq "Primeira Malha"
        expect(result["source_point"]["city"]).to eql "Campinas"
        expect(result["destination_point"]["city"]).to eql "São Paulo"
      end
    end
  end

  describe 'GET best_delivery' do
    before { get "/highway_network/best_delivery", request_params.to_query }

    context 'failure' do
      context 'fails when no params was sent' do
        let(:request_params) { {} }
        before { get'/highway_network/best_delivery' }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Missing Parameters.\"}" }
      end

      context 'fails when source point param was not sent' do
        let(:request_params) { {destination_point: "São Paulo", consumo_caminhao: "10", valor_litro: "2.30" } }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Missing Parameters.\"}" }
      end

      context 'fails when destination point param was not sent' do
        let(:request_params) { {source_point: "São Paulo", consumo_caminhao: "10", valor_litro: "2.30" } }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Missing Parameters.\"}" }
      end

      context 'fails when consumo caminhao param was not sent' do
        let(:request_params) { {source_point: "São Paulo", destination_point: "Campinas", valor_litro: "2.30" } }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Missing Parameters.\"}" }
      end

      context 'fails when valor litro param was not sent' do
        let(:request_params) { {source_point: "São Paulo", destination_point: "Campinas", consumo_caminhao: "10" } }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Missing Parameters.\"}" }
      end

      context 'fails when consumo caminhao is not a valid value' do
        let(:request_params) { {source_point: "São Paulo", destination_point: "Campinas", consumo_caminhao: "XX", valor_litro: "2.30" } }

        its(:status) { should eq 400 }
        its(:body)   { should eq "{\"errors\":\"Bad request. Invalid value.\"}" }
      end

      context 'fails when point was not found' do
        let(:request_params) { {source_point: "Distribuidor Bahia", destination_point: "Distribuidor Campinas", consumo_caminhao: "10", valor_litro: "2.30" } }

        it "should return not found when source not found" do
          network = FactoryGirl.create(:highway_network)
          last_response = get "/highway_network/best_delivery", request_params.to_query

          expect(last_response.status).to eql 404
          expect(last_response.body).to eq "{\"errors\":\"Point not found.\"}"
        end

        it "should return not found when destination not found" do
          request_params = {source_point: "Distribuidor São Paulo", destination_point: "Distribuidor Bahia", consumo_caminhao: "10", valor_litro: "2.30" }
          network = FactoryGirl.create(:highway_network)
          last_response = get "/highway_network/best_delivery", request_params.to_query

          expect(last_response.status).to eql 404
          expect(last_response.body).to eq "{\"errors\":\"Point not found.\"}"
        end
      end
    end

    context 'success' do
      before do
        point_A = FactoryGirl.create(:delivery_point, description: 'A', city: 'A', state: 'SP')
        point_B = FactoryGirl.create(:delivery_point, description: 'B', city: 'B', state: 'SP')
        point_C = FactoryGirl.create(:delivery_point, description: 'C', city: 'C', state: 'SP')
        point_D = FactoryGirl.create(:delivery_point, description: 'D', city: 'D', state: 'SP')
        point_E = FactoryGirl.create(:delivery_point, description: 'E', city: 'E', state: 'SP')

        FactoryGirl.create(:highway_network, description: 'A -> B' ,source_point: point_A, destination_point: point_B, distance: "10")
        FactoryGirl.create(:highway_network, description: 'B -> D' ,source_point: point_B, destination_point: point_D, distance: "15")
        FactoryGirl.create(:highway_network, description: 'A -> C' ,source_point: point_A, destination_point: point_C, distance: "20")
        FactoryGirl.create(:highway_network, description: 'C -> D' ,source_point: point_C, destination_point: point_D, distance: "30")
        FactoryGirl.create(:highway_network, description: 'B -> E' ,source_point: point_B, destination_point: point_E, distance: "50")
        FactoryGirl.create(:highway_network, description: 'D -> E' ,source_point: point_D, destination_point: point_E, distance: "30")
      end

      context 'return the most economic route for A -> D' do
        let(:request_params) { {source_point: "A", destination_point: "D", consumo_caminhao: "10", valor_litro: "2.50" } }

        it "should return the lower cost route for A->D" do
          last_response = get "/highway_network/best_delivery", request_params.to_query
          expect(last_response.status).to eql 200
          expect(last_response.body).to eq "Valor Consumo R$ 6.25 Melhor Rota A -> B -> D"
        end
      end

      context 'return the most economic route for A -> C' do
        let(:request_params) { {source_point: "A", destination_point: "C", consumo_caminhao: "10", valor_litro: "2.50" } }

        it "should return the lower cost route for A -> C" do
          last_response = get "/highway_network/best_delivery", request_params.to_query
          expect(last_response.status).to eql 200
          expect(last_response.body).to eq "Valor Consumo R$ 5.0 Melhor Rota A -> C"
        end
      end

      context 'return the most economic route for B -> E' do
        let(:request_params) { {source_point: "B", destination_point: "E", consumo_caminhao: "10", valor_litro: "2.50" } }

        it "should return the lower cost route for B -> E" do
          last_response = get "/highway_network/best_delivery", request_params.to_query
          expect(last_response.status).to eql 200
          expect(last_response.body).to eq "Valor Consumo R$ 12.5 Melhor Rota B -> E"
        end
      end
    end
  end

  def app
    Rack::URLMap.new BestDelivery.route_map
  end

end
