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
      allergy = Allergy.new(name: 'Lantus', cause: 'Medicamento', description: 'Princípio Ativo: Insulina Glargina', start: Time.now, finish: Time.now, profile: @existing_profile)
      expect(allergy).to be_valid
    end

    it 'Should have a profile associated' do
      allergy = Allergy.new(name: 'Lantus', cause: 'Medicamento', description: 'Princípio Ativo: Insulina Glargina', start: Time.now, finish: Time.now, profile: nil)
      expect(allergy).to_not be_valid
    end

	it 'Should have current date if date was not informed' do
      allergy = Allergy.new(name: 'Lantus', cause: 'Medicamento', description: 'Princípio Ativo: Insulina Glargina', profile: @existing_profile)
      expect(allergy.start.to_date).to eq(Time.now.to_date)
    end
	
    it 'Is not valid without a value' do
      allergy = Allergy.new(name: nil, cause: nil, description: nil, start: Time.now,finish: Time.now, profile: @existing_profile)
      expect(allergy).to_not be_valid
    end
  end
end 