class BodyMassIndex

    def self.calculate(weight, height)
        if weight and height 
            (weight / (height ** 2)).round(1) 
        end
    end
end
