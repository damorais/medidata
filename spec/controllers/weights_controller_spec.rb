require 'rails_helper'

RSpec.describe WeightsController, type: :controller do

    @existing_profile
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    it "Should retrieve a page with all weights registered from an user" do

        get :index, params: { profile_email: @existing_profile.email }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
    end

    it "Should retrieve all weights registered for the current user" do
        get :index, params: { profile_email: @existing_profile.email }
       
        expect(assigns(:weights)).to eq(@existing_profile.weights)
    end

    it "Should render a template that allows to register a new weight" do
        get :new, params: { profile_email: @existing_profile.email }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
    end

    it "Should register a new weight with a date" do
        expect {
            post :create, :params => {profile_email: @existing_profile.email, :weight => { 
                value: 70, 
                date: 1.day.ago } 
            }
        }.to change(@existing_profile.weights, :count)
    end

    it "Should redirect to the profiles page after adding a new weight" do
        post :create, :params => {profile_email: @existing_profile.email, :weight => { 
            value: 70, 
            date: 1.day.ago } 
        }

        expect(response).to redirect_to(profile_weights_path(profile_email: @existing_profile.email))
    end

end
