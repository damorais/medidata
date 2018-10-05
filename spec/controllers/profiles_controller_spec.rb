require 'factory_bot'
require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

    it "Should return the Create your Profile page" do
        get :new
        assert_response :success
    end

    it "Should create a new profile" do
        expect {
            post :create, :params => { :profile  => { 
                email: "joao@example.org",
                firstname: "João",
                lastname: "Silva",
                birthdate: "2000-12-15",
                sex: "Male",
                gender: "Male" } 
            }
        }.to change(Profile, :count)

        expect(response).to have_http_status(:success)
    end

    it "Should not allow to create a new profile without required fields" do 
        expect {
            post :create, :params => { :profile  => { 
                                        email: "",
                                        firstname: "",
                                        lastname: "",
                                        birthdate: "",
                                        sex: "",
                                        gender: "" } 
            }
        }.to_not change(Profile, :count)

        expect(response).to render_template(:new)
    end

    describe 'As a existing user' do
        # @existing_user_email = "joao@example.org"
        # before { FactoryBot.create :profile, :email => "existing_user_email"  } 

        it "I should be able to access my profile page details" do
            existing_user_email = "joao@example.org"

            profile = FactoryBot.create(:profile, :email => existing_user_email)
            
            get :show, params: { email: existing_user_email }

            expect(response).to have_http_status(:success)
            expect(assigns(:profile)).to eq(profile)
            expect(response).to render_template(:show)
            
        end

    end

    

end
