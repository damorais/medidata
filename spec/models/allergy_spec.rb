# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Allergy, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end

  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      allergy = Allergy.new(name: 'Lantus', description: 'Princípio Ativo: Insulina Glargina', profile: @existing_profile)
      expect(allergy).to be_valid
    end

    it 'Should have a profile associated' do
      allergy = Allergy.new(name: 'Lantus', description: 'Princípio Ativo: Insulina Glargina', profile: nil)
      expect(allergy).to_not be_valid
    end

    it 'Is not valid without a value' do
      allergy = Allergy.new(name: nil, description: nil, profile: @existing_profile)
      expect(allergy).to_not be_valid
    end
  end
end
