# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :profile

  validates :email, presence: { message: 'The value must be provided' }
  validates :name, presence: { message: 'The value must be provided' }
  validates :phone, presence: { message: 'The value must be provided' }
  validates :mobile, presence: { message: 'The value must be provided' }
end
