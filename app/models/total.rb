class Total < ApplicationRecord
  belongs_to :profile
  after_initialize :set_defaults

  validates :value, presence: { message: "The value must be provided" },
                    numericality: {
                      greater_than: 0
                    }
  validates :date, presence: { message: "A date must be informed" }

  def set_defaults
    self.date = Time.now unless self.date
  end  
end
