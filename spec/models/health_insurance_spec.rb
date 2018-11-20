require 'rails_helper'

RSpec.describe HealthInsurance, type: :model do
  it { should belong_to :profile }

  describe 'Validations' do
    before do
      @existing_profile= FactoryBot.create :profile, email: 'joao@example.org'
    end

    it 'Is valid with valid attributes' do
      health_insurance = FactoryBot.build :health_insurance, name: 'My favorite health insurance',
                                                             provider: 'Medidata HealthCare',
                                                             plan_type: 'Medical',
                                                             plan_name: 'Super 2000',
                                                             plan_number: '2018-123456',
                                                             start_date: Date.new(2017, 12, 1),
                                                             profile: @existing_profile

      expect(health_insurance).to be_valid
    end

    it 'Is not valid without a name' do
      health_insurance = HealthInsurance.new name: '',
                                             provider: 'Medidata HealthCare',
                                             plan_type: 'Medical',
                                             plan_name: 'Super 2000',
                                             plan_number: '2018-123456',
                                             start_date: Date.new(2017, 12, 1),
                                             profile: @existing_profile

      expect(health_insurance).to_not be_valid
    end

    it 'Is not valid without a provider' do
      health_insurance = HealthInsurance.new(name: 'My favorite health insurance',
                                             provider: '',
                                             plan_type: 'Medical',
                                             plan_name: 'Super 2000',
                                             plan_number: '2018-123456',
                                             start_date: Date.new(2017, 12, 1),
                                             profile: @existing_profile)

      expect(health_insurance).to_not be_valid
    end

    it 'Is not valid without a type' do
      health_insurance = HealthInsurance.new(name: 'My favorite health insurance',
                                             provider: 'Medidata HealthCare',
                                             plan_type: '',
                                             plan_name: 'Super 2000',
                                             plan_number: '2018-123456',
                                             start_date: Date.new(2017, 12, 1),
                                             profile: @existing_profile)

      expect(health_insurance).to_not be_valid
    end

    it 'Is not valid without plan number' do
      health_insurance = HealthInsurance.new(name: 'My favorite health insurance',
                                             provider: 'Medidata HealthCare',
                                             plan_type: 'Medical',
                                             plan_name: 'Super 2000',
                                             plan_number: '',
                                             start_date: Date.new(2017, 12, 1),
                                             profile: @existing_profile)

      expect(health_insurance).to_not be_valid
    end

    it 'Is not valid without a start_date' do
      health_insurance = HealthInsurance.new(name: 'My favorite health insurance',
                                             provider: 'Medidata HealthCare',
                                             plan_type: 'Medical',
                                             plan_name: 'Super 2000',
                                             plan_number: '2018-123456',
                                             start_date: nil, 
                                             profile: @existing_profile)

      expect(health_insurance).to_not be_valid
    end

    it 'Is not valid without a profile' do
      health_insurance = HealthInsurance.new(name: 'My favorite health insurance',
                                             provider: 'Medidata HealthCare',
                                             plan_type: 'Medical',
                                             plan_name: 'Super 2000',
                                             plan_number: '2018-123456',
                                             start_date: Date.new(2017, 12, 1),
                                             profile: nil )

      expect(health_insurance).to_not be_valid
    end

  end

end
