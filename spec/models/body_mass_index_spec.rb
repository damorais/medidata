require 'rails_helper'

RSpec.describe BodyMassIndex, type: :model do

    it "Should calculate a body mass index given a weight and a height" do

        bmi_result = BodyMassIndex.calculate(65, 1.85)

        expect(bmi_result).to eq(19)
    end

    it "Should return nothing if weight is not informed" do

        bmi_result = BodyMassIndex.calculate(nil, 1.85)

        expect(bmi_result).to eq(nil)
    end

    it "Shoud return nothing if height is not informed" do
        bmi_result = BodyMassIndex.calculate(65, nil)

        expect(bmi_result).to eq(nil)
    end

end