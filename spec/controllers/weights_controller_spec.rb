require 'rails_helper'

RSpec.describe WeightsController, type: :controller do

    @existing_profile
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    it "Should retrieve a page with all weights registered from an user" do

        get :index, params: { profile_email: @existing_profile.email }

        expect(response).to have_http_status(:success)
        expect(assigns(:weights)).to eq(@existing_profile.weights)
        expect(response).to render_template(:index)

    end

end
