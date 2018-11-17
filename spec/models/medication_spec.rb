# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Medication, type: :model do
  describe 'Associations' do
    it { should belong_to :profile }
  end
end
