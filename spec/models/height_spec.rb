# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Height, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
  
  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      height = Height.new(value: 1.65, date: Time.now, profile: @existing_profile)
      expect(height).to be_valid
    end

    it 'Should have a profile associated' do
      height = Height.new(value: 1.65, date: Time.now, profile: nil)
      expect(height).to_not be_valid
    end

    it 'Should have current date if date was not informed' do
      height = Height.new(value: 1.65, profile: @existing_profile)
      expect(height.date.to_date).to eq(Time.now.to_date)
    end

    it 'Is not valid without a value' do
      height = Height.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(height).to_not be_valid
    end

    it 'Value should not be 0' do
      height = Height.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(height).to_not be_valid
    end

    it 'Value should not lesser than 0' do
      height = Height.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(height).to_not be_valid
    end
  end
end
