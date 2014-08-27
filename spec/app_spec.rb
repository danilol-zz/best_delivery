# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/spec_helper'

describe BestDelivery::App do
  include Rack::Test::Methods

  def app
    Rack::URLMap.new BestDelivery.route_map
  end

  context 'when asking for options' do
    subject { get '/' }

    context 'digest' do
      before do
        Digest::MD5.should_receive(:hexdigest).with(anything).and_return('a')
        subject
      end

      it 'should have etag' do
        last_response.should be_ok
        last_response.headers['Etag'].should eq '"%s"' % 'a'
      end
    end

    context 'should return the API index' do
      context '/user resource' do
        before { subject }
        let(:result) { JSON.parse last_response.body }
        let(:best_delivery) { result['best_delivery'] }
        let(:user) { best_delivery.find { |e| e['rel'] == 'user' } }


        it { user['href'].should == '/user' }
        it { user['type'].should == 'application/best_delivery.user+json;charset=utf-8' }
      end
    end
  end
end
