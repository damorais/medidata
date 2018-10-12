require 'rails_helper'
require 'date'

RSpec.describe Weight, type: :model do
  describe "Validations" do

    @existing_profile
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    it "Is valid with valid attributes" do
      weight = Weight.new(value: 60, date: Time.now, profile: @existing_profile)
      expect(weight).to be_valid
    end

    it "Should have a profile associated" do
      weight = Weight.new(value: 60, date: Time.now, profile: nil)
      expect(weight).to_not be_valid
    end

    it "Should have current date if date was not informed" do
      weight = Weight.new(value: 60, profile: @existing_profile)
      expect(weight.date.to_date).to eq(Time.now.to_date)
    end

    it "Is not valid without a value" do
      weight = Weight.new(value: nil, date: Time.now, profile: @existing_profile)
      expect(weight).to_not be_valid
    end

    it "Value should not be 0" do
      weight = Weight.new(value: 0, date: Time.now, profile: @existing_profile)
      expect(weight).to_not be_valid
    end

    it "Value should not lesser than 0" do
      weight = Weight.new(value: -1, date: Time.now, profile: @existing_profile)
      expect(weight).to_not be_valid
    end
  end

end
