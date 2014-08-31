# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BestDelivery::HighwayNetwork do
  describe "Fields" do
    it { should have_fields(:description, :source_point, :destination_point).of_type(String) }
    it { should have_fields(:distance).of_type(Integer) }
  end

  describe 'Validations' do
    context 'presence' do
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:source_point) }
      it { should validate_presence_of(:destination_point) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:description) }
    end

    context 'length' do
      it { should validate_length_of(:description).with_maximum(100) }
    end

    context 'numericality' do
      it { should validate_numericality_of(:distance) }
    end

    context 'Indexes' do
      it { should have_index_for(description: 1) }
    end

    context 'validate existence of points' do
      before :all do
        @unpersisted_point = FactoryGirl.build(:delivery_point, description: 'Distribuidor Rio de Janeiro', city: 'São Paulo', state: 'SP')
      end

      it "should validate source point" do
        network = FactoryGirl.build(:highway_network, destination_point: @unpersisted_point)

        expect(network).to be_invalid
      end

      it "should validate destination point" do
        network = FactoryGirl.build(:highway_network, source_point: @unpersisted_point)

        expect(network).to be_invalid
      end
    end
  end
end
