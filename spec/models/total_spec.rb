# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Total, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
  
  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      total = Total.new(value: 189, date: Time.now, profile: @existing_profile)
      expect(total).to be_valid
    end

    it 'Should have a profile associated' do
      total = Total.new(value: 189, date: Time.now, profile: nil)
      expect(total).to_not be_valid
    end

    it 'Should have current date if date was not informed' do
      total = Total.new(value: 189, profile: @existing_profile)
      expect(total.date.to_date).to eq(Time.now.to_date)
    end

    it 'Is not valid without a value' do
      total = Total.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(total).to_not be_valid
    end

    it 'Value should not be 0' do
      total = Total.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(total).to_not be_valid
    end

    it 'Value should not lesser than 0' do
      total = Total.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(total).to_not be_valid
    end
  end
end
