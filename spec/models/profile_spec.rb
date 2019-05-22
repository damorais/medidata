# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to :user }

  it { should have_many :allergies }
  it { should have_many :contacts }
  it { should have_many :glucose_measures }
  it { should have_many :hdls }
  it { should have_many :heights }
  it { should have_many :ldls }
  it { should have_many :medications }
  it { should have_many :medical_appointments }
  it { should have_many :non_hdls }
  it { should have_many :pressures }
  it { should have_many :reactions }
  it { should have_many :totals }
  it { should have_many :vldls }
  it { should have_many :weights }
  it { should have_many :health_insurances }
  it { should have_many :diseases }

  describe 'Validations' do
    it 'Is valid with valid attributes' do
      profile = FactoryBot.build :profile, email: 'joao_silva@example.org',
                                           firstname: 'João',
                                           lastname: 'Silva',
                                           birthdate: Date.new(2000, 5, 5)

      expect(profile).to be_valid
    end

    it 'Is not valid without an email' do
      profile = Profile.new(email: nil)
      expect(profile).to_not be_valid
    end

    it 'Is not valid if the email is not unique' do
      existing_profile = FactoryBot.create :profile, email: 'joao_silva@example.org',
                                                  firstname: 'João',
                                                  lastname: 'Silva',
                                                  birthdate: Date.new(2000, 5, 5)

      profile = Profile.new(email: existing_profile.email,
                            firstname: 'João',
                            lastname: 'Silva',
                            birthdate: Date.new(2000, 5, 5),
                            user: existing_profile.user)

      expect(profile).to_not be_valid
    end

    it 'Is not valid without a firstname' do
      profile = Profile.new(firstname: nil)
      expect(profile).to_not be_valid
    end

    it 'Is not valid without a lastname' do
      profile = Profile.new(lastname: nil)
      expect(profile).to_not be_valid
    end

    it 'Is not valid without a birthdate' do
      profile = Profile.new(birthdate: nil)
      expect(profile).to_not be_valid
    end
  end
  describe 'Associated values with profile' do 
    context 'Associated Weights' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @latest_weight = FactoryBot.create :weight, date: Time.now, profile: @existing_profile
        @other_weight = FactoryBot.create :weight, date: 1.day.ago, profile: @existing_profile
      end

      it 'Should return the latest weight of a profile' do
        expect(@existing_profile.latest_weight).to eq(@latest_weight)
      end
    end

    context 'Associated Heights' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @latest_height = FactoryBot.create :height, date: Time.now, profile: @existing_profile
        @other_height = FactoryBot.create :height, date: 1.day.ago, profile: @existing_profile
      end

      it 'Should return the latest height of a profile' do
        expect(@existing_profile.latest_height).to eq(@latest_height)
      end
    end
    context 'Associated Glucose' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @latest_glucose = FactoryBot.create :value, date: Time.now  ,profile: @existing_profile
        @other_glucose = FactoryBot.create :val , date: 1.day.ago ,profile: @existing_profile
      end
      it 'Should return the latest glucose mensure of a profile' do
        expect(@existing_profile.latest_glucose).to eq(@latest_glucose)
      end  

    end 
  end
  describe 'BMI' do
    context 'With valid height and weight' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @weight = FactoryBot.create :weight, date: Time.now, profile: @existing_profile, value: 65
        @height = FactoryBot.create :height, date: Time.now, profile: @existing_profile, value: 1.85
      end

      it 'Should return the bmi value for the current profile' do
        expect(@existing_profile.bmi).to eq(19)
      end
    end

    context 'Without height' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @weight = FactoryBot.create :weight, date: Time.now, profile: @existing_profile, value: 65
      end

      it 'Should return nil as the bmi value for the current profile' do
        expect(@existing_profile.bmi).to eq(nil)
      end
    end

    context 'Without weight' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
        @height = FactoryBot.create :height, date: Time.now, profile: @existing_profile, value: 1.85
      end

      it 'Should return nil as the bmi value for the current profile' do
        expect(@existing_profile.bmi).to eq(nil)
      end
    end
  end
end
