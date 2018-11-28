require 'rails_helper'

RSpec.describe Disease, type: :model do
  describe "Validations" do

    @existing_profile
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    it "Is valid with valid attributes" do
      disease = Disease.new(name: "Cardiaca", description: "Arritmia", start: Time.now ,finish: Time.now , profile: @existing_profile)
      expect(disease).to be_valid
    end

    it "Should have a profile associated" do
      disease = Disease.new(name: "Cardiaca", description: "Arritmia", start: Time.now ,finish: Time.now, profile: nil)
      expect(disease).to_not be_valid
    end

	it "Should have current date if date was not informed" do
      disease = Disease.new(name: "Cardiaca", description: "Arritmia", profile: @existing_profile)
      expect(disease.start.to_date).to eq(Time.now.to_date)
    end
	
    it "Is not valid without a value" do
      disease = Disease.new(name: nil, description: nil, start: Time.now,finish: Time.now, profile: @existing_profile)
      expect(disease).to_not be_valid
    end

  end
end
