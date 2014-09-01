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
          let(:user_params) { { name: 'Danilo Lima', email: nil, cpf: '341.213.888-60', dob: '11/03/1987' } }

          before { post '/user', user_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"email\":[\"can't be blank\"]}}" }
        end
      end
    end

    #context 'success' do
      #let(:user_params) { { name: 'danilo lima', email: 'danilo@eu.com', cpf: '341.213.888-60', dob: '11/03/1987' } }

      #before { post '/user', user_params.to_json }

      #its(:status) { should eq 201 }
      #its(:body)   { should be_empty }

      #it 'should return the user href' do
        #user = BestDelivery::User.find_by(email: user_params[:email])
        #expect(user.name).to  eq user_params[:name]
        #expect(user.email).to eq user_params[:email]
        #expect(user.cpf).to eq user_params[:cpf]
        #expect(user.dob.strftime("%d/%m/%Y")).to eq user_params[:dob]
        #expect(subject.headers["Location"]).to eq "/user/#{user.id}"
      #end
    #end
  end

  #context 'GET a user by its id' do
    #let(:user_id) { 'C01DC0FFEE' }

    #context 'non-existing user' do
      #before do
        #BestDelivery::User.should_receive(:find).with(user_id).and_raise(Mongoid::Errors::DocumentNotFound.allocate)
      #end

      #it 'returns a 404' do
        #get "/user/#{user_id}"
        #last_response.status.should == 404
      #end
    #end

    #context 'existing user' do
      #let(:user) { FactoryGirl.build(:user) }

      #before { BestDelivery::User.should_receive(:find).with(user_id).and_return(user) }

      #it 'returns the JSON resource of that user' do
        #get "/user/#{user_id}"
        #last_response.should be_ok

        #resource = JSON.parse(last_response.body)
        #resource['name'].should  == 'Maria Antonieta Sousa'
        #resource['cpf'].should   == '75210981452'
        #resource['email'].should == 'teste@teste.com.br'
        #resource['dob'].should   == '1987-03-11'
      #end
    #end
  #end

  def app
    Rack::URLMap.new BestDelivery.route_map
  end
end
