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

end
