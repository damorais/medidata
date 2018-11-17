# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vldl, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
  
  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      vldl = Vldl.new(value: 64, date: Time.now, profile: @existing_profile)
      expect(vldl).to be_valid
    end

    it 'Should have a profile associated' do
      vldl = Vldl.new(value: 64, date: Time.now, profile: nil)
      expect(vldl).to_not be_valid
    end

    it 'Should have current date if date was not informed' do
      vldl = Vldl.new(value: 64, profile: @existing_profile)
      expect(vldl.date.to_date).to eq(Time.now.to_date)
    end

    it 'Is not valid without a value' do
      vldl = Vldl.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(vldl).to_not be_valid
    end

    it 'Value should not be 0' do
      vldl = Vldl.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(vldl).to_not be_valid
    end

    it 'Value should not lesser than 0' do
      vldl = Vldl.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(vldl).to_not be_valid
    end
  end
end
