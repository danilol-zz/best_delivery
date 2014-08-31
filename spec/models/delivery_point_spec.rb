# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BestDelivery::DeliveryPoint do
  describe "Fields" do
    it { should have_fields(:description, :city, :state).of_type(String) }
  end

  describe 'Validations' do
    context 'presence' do
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:description) }
    end

    context 'uniqueness' do
      it { should validate_length_of(:description).with_maximum(100) }
      it { should validate_length_of(:city).with_maximum(50) }
      it { should validate_length_of(:state).with_maximum(20) }
    end

    describe 'Indexes' do
      it { should have_index_for(description: 1) }
    end
  end
end
