require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe "Validations" do

    @existing_profile
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    it "Is valid with valid attributes" do
      reaction = Reaction.new(name: "Propofol", cause: "Rabdomiolise", description: "Medicamento", start: Time.now ,finish: Time.now , profile: @existing_profile)
      expect(reaction).to be_valid
    end

    it "Should have a profile associated" do
      reaction = Reaction.new(name: "Propofol", cause: "Rabdomiolise", description: "Medicamento", start: Time.now ,finish: Time.now, profile: nil)
      expect(reaction).to_not be_valid
    end

	it "Should have current date if date was not informed" do
      reaction = Reaction.new(name: "Propofol", cause: "Rabdomiolise", description: "Medicamento", profile: @existing_profile)
      expect(reaction.start.to_date).to eq(Time.now.to_date)
    end
	
    it "Is not valid without a value" do
      reaction = Reaction.new(name: nil, cause: nil, description: nil, start: Time.now,finish: Time.now, profile: @existing_profile)
      expect(reaction).to_not be_valid
    end

  end
end
