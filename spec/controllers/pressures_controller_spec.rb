require 'rails_helper'

RSpec.describe PressuresController, type: :controller do

  before  {
       @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
  }

  describe "GET #index" do
      it "returns a success response" do
          get :index, params: { profile_email: @existing_profile.email }
          expect(response).to be_successful
      end
  end

end
