require 'rails_helper'

RSpec.describe Profile, type: :model do

  describe "Validations" do
    it "Is valid with valid attributes" do
      profile = Profile.new(email: "joao_silva@example.org", 
                            firstname: "João", 
                            lastname: "Silva", 
                            birthdate: Date.new(2000, 5, 5))

      expect(profile).to be_valid
    end

    it "Is not valid without an email" do
      profile = Profile.new(email: nil)
      expect(profile).to_not be_valid
    end
    
    it "Is not valid if the email is not unique" do
      Profile.create(email: "joao_silva@example.org", 
                     firstname: "João", 
                     lastname: "Silva", 
                     birthdate: Date.new(2000, 5, 5))
      profile = Profile.new(email: "joao_silva@example.org", 
                            firstname: "João", 
                            lastname: "Silva", 
                            birthdate: Date.new(2000, 5, 5))
      expect(profile).to_not be_valid

    end

    it "Is not valid without a firstname" do
      profile = Profile.new(firstname: nil)
      expect(profile).to_not be_valid
    end

    it "Is not valid without a lastname" do
      profile = Profile.new(lastname: nil)
      expect(profile).to_not be_valid
    end

    it "Is not valid without a birthdate" do 
      profile = Profile.new(birthdate: nil)
      expect(profile).to_not be_valid
    end
  end

  context "Associated Weights" do

    before { 
      @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
      @latest_weight = FactoryBot.create :weight, :date => Time.now, :profile => @existing_profile
      @other_weight = FactoryBot.create :weight, :date => 1.day.ago, :profile => @existing_profile
    }

    it "Should return the latest weight of a profile" do
      expect(@existing_profile.latest_weight).to eq(@latest_weight)
    end

  end

  context "Associated Heights" do

    before { 
      @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
      @latest_height = FactoryBot.create :height, :date => Time.now, :profile => @existing_profile
      @other_height = FactoryBot.create :height, :date => 1.day.ago, :profile => @existing_profile
    }

    it "Should return the latest height of a profile" do
      expect(@existing_profile.latest_height).to eq(@latest_height)
    end

  end

  describe "BMI" do

    context "With valid height and weight" do
      before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
        @weight = FactoryBot.create :weight, :date => Time.now, :profile => @existing_profile, :value => 65
        @height = FactoryBot.create :height, :date => Time.now, :profile => @existing_profile, :value => 1.85
      }

      it "Should return the bmi value for the current profile" do
        expect(@existing_profile.bmi).to eq(19)
      end
    end
    
    context "Without height" do 
      before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
        @weight = FactoryBot.create :weight, :date => Time.now, :profile => @existing_profile, :value => 65
      }

      it "Should return nil as the bmi value for the current profile" do
        expect(@existing_profile.bmi).to eq(nil)
      end
    end

    context "Without weight" do 
      before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
        @height = FactoryBot.create :height, :date => Time.now, :profile => @existing_profile, :value => 1.85
      }

      it "Should return nil as the bmi value for the current profile" do
        expect(@existing_profile.bmi).to eq(nil)
      end
    end
  end
end