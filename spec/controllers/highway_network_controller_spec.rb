# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BestDelivery::Controllers::HighwayNetworkController do
  context 'create' do

    subject { last_response }

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

          let(:highway_network_params) { { source_point: source, destination_point: destination, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"description\":[\"can't be blank\"]}}" }
        end

        context 'fails when a required field was sent with nil value' do
          let(:source)      { FactoryGirl.create(:delivery_point) }
          let(:destination) { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }

          let(:highway_network_params) { { description: nil, source_point: source, destination_point: destination, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"description\":[\"can't be blank\"]}}" }
        end

        context 'fails when a point field was sent with invalid value' do
          let(:source)      { FactoryGirl.create(:delivery_point) }
          let(:destination) { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }

          let(:highway_network_params) { { description: 'test', source_point: "teste", destination_point: destination, distance: 20 } }

          before { post '/highway_network', highway_network_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"source_point\":[\"can't be blank\",\"Origem inválida!!\"]}}" }
        end

        context 'conflict' do
          let(:source)          { FactoryGirl.create(:delivery_point) }
          let(:destination)     { FactoryGirl.create(:delivery_point, description: 'XIQUITONES', city: 'Rio de Janeiro', state: 'RJ') }
          let(:highway_network_params) { { description: 'Primeira Malha', source_point: source, destination_point: destination, distance: 10 } }

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
      let(:highway_network_params) { { description: 'Primeira Malha', source_point: source, destination_point: destination, distance: 10 } }

      before { post '/highway_network', highway_network_params.to_json }

      its(:status) { should eq 201 }
      its(:body)   { should eq "" }
    end
  end

  def app
    Rack::URLMap.new BestDelivery.route_map
  end
end
