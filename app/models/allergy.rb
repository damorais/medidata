class Allergy < ApplicationRecord
  belongs_to :profile
  after_initialize :set_defaults
  
  validates :name, presence: { message: "The value must be provided" }
  validates :cause, presence: { message: "The cause must be provided" }     
  validates :description, presence: { message: "The value must be provided" }
  validates :start, presence: { message: "A date must be informed" }  
  
  def set_defaults
    self.start = Time.now unless self.start
  end
end
