class Relative < ApplicationRecord
  belongs_to :profile

  after_initialize :set_defaults

  validates :name, presence: { message: "The value must be provided" }
  validates :description, presence: { message: "The description must be provided" } 
  validates :kinship, presence: { message: "A kinship must be informed" }
  
  def set_defaults
    self.start = Time.now unless self.start
  end
end
