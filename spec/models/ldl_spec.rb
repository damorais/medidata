# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ldl, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
  
  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      ldl = Ldl.new(value: 80, date: Time.now, profile: @existing_profile)
      expect(ldl).to be_valid
    end

    it 'Should have a profile associated' do
      ldl = Ldl.new(value: 80, date: Time.now, profile: nil)
      expect(ldl).to_not be_valid
    end

    it 'Should have current date if date was not informed' do
      ldl = Ldl.new(value: 80, profile: @existing_profile)
      expect(ldl.date.to_date).to eq(Time.now.to_date)
    end

    it 'Is not valid without a value' do
      ldl = Ldl.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(ldl).to_not be_valid
    end

    it 'Value should not be 0' do
      ldl = Ldl.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(ldl).to_not be_valid
    end

    it 'Value should not lesser than 0' do
      ldl = Ldl.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(ldl).to_not be_valid
    end
  end
end
