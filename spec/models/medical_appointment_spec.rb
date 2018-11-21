# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MedicalAppointment, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end

  describe 'Validations' do
    # validates :specialty, presence: { message: 'The value must be provided' }
    # validates :address, presence: { message: 'The value must be provided' }
    # validates :professional, presence: { message: 'The value must be provided' }

    before do
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      appointment = MedicalAppointment.new(specialty: 'Oncology',
                                       address: 'Av. Paulista, 1000',
                                       professional: 'Dr. Hans Chucrute',
                                       profile: @existing_profile)
      expect(appointment).to be_valid
    end

    it 'Should have a profile associated' do
      appointment = MedicalAppointment.new(specialty: 'Oncology',
                                           address: 'Av. Paulista, 1000',
                                           professional: 'Dr. Hans Chucrute',
                                           profile: nil)

      expect(appointment).to_not be_valid
    end

    it 'Is not valid without a speciality' do
      appointment = MedicalAppointment.new(specialty: '',
                                           address: 'Av. Paulista, 1000',
                                           professional: 'Dr. Hans Chucrute',
                                           profile: @my_profile)

      expect(appointment).to_not be_valid
    end

    it 'Is not valid without an address' do
      appointment = MedicalAppointment.new(specialty: 'Oncology',
                                           address: '',
                                           professional: 'Dr. Hans Chucrute',
                                           profile: @my_profile)

        expect(appointment).to_not be_valid
    end

    it 'Is not valid without a professional' do
      appointment = MedicalAppointment.new(specialty: 'Oncology',
                                           address: 'Av. Paulista, 1000',
                                           professional: '',
                                           profile: @my_profile)

        expect(appointment).to_not be_valid
    end
  end
end
