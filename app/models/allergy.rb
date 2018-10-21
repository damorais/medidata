class Allergy < ApplicationRecord
	belongs_to :profile
  
    validates :name, presence: { message: "The value must be provided" }
	validates :description, presence: { message: "The value must be provided" }	
end
