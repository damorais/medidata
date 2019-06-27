class Relative < ApplicationRecord
  belongs_to :profile

  validates :name, presence: { message: "The value must be provided" }
  validates :description, presence: { message: "The description must be provided" } 
  validates :kinship, presence: { message: "A kinship must be informed" }
  
end
