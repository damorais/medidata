# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
  
  describe 'Validations' do
    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      contact = Contact.new(email: 'silvia@example.org', name: 'Silvia', phone: '1112828', mobile: '11981812828', profile: @existing_profile)
      expect(contact).to be_valid
    end

    it 'Should have a profile associated' do
      contact = Contact.new(email: 'silvia@example.org', name: 'Silvia', phone: '1112828', mobile: '11981812828', profile: nil)
      expect(contact).to_not be_valid
    end

    it 'Is not valid without a value' do
      contact = Contact.new(email: nil, name: nil, phone: nil, mobile: nil, profile: @existing_profile)
      expect(contact).to_not be_valid
    end
  end
end
