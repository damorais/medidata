require 'rails_helper'
require 'date'


RSpec.describe GlucoseMeasure, type: :model do
  describe "Validations" do

    before {
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    }

    it "Is valid with valid attributes" do
      glucose = GlucoseMeasure.new(value: 80, fasting: true, date: DateTime.now, profile: @existing_profile)
      expect(glucose).to be_valid
    end

    it "Should have a profile associated" do
      glucose = GlucoseMeasure.new(value: 80, fasting: true, date: DateTime.now, profile: nil)
      expect(glucose).to_not be_valid
    end

    it "Is not valid without a value" do
      glucose = GlucoseMeasure.new(value: nil, fasting: true, date: DateTime.now, profile: @existing_profile)
      expect(glucose).to_not be_valid
    end

    it "Value should not lesser than 0" do
      glucose = GlucoseMeasure.new(value: -1, fasting: true, date: DateTime.now, profile: @existing_profile)
      expect(glucose).to_not be_valid
    end
  end
end
