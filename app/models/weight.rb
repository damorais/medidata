class Weight < ApplicationRecord
  belongs_to :profile
  after_initialize :set_defaults

  def set_defaults
    self.date = Time.now
  end
end
