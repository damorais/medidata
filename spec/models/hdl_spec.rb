# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hdl, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end

  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      hdl = Hdl.new(value: 120, date: Time.now, profile: @existing_profile)
      expect(hdl).to be_valid
    end

    it 'Should have a profile associated' do
      hdl = Hdl.new(value: 120, date: Time.now, profile: nil)
      expect(hdl).to_not be_valid
    end

    it 'Should have current date if date was not informed' do
      hdl = Hdl.new(value: 120, profile: @existing_profile)
      expect(hdl.date.to_date).to eq(Time.now.to_date)
    end

    it 'Is not valid without a value' do
      hdl = Hdl.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(hdl).to_not be_valid
    end

    it 'Value should not be 0' do
      hdl = Hdl.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(hdl).to_not be_valid
    end

    it 'Value should not lesser than 0' do
      hdl = Hdl.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(hdl).to_not be_valid
    end
  end
end
