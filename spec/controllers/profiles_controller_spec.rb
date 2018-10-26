require 'factory_bot'
require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

    let(:valid_attributes) {
        {
            email: "joao@example.org",
            firstname: "João",
            lastname: "Silva",
            birthdate: "2000-12-15"
        }
    }

    let(:invalid_attributes) {
        {
            email: "",
            firstname: "",
            lastname: "",
            birthdate: ""
        }
    }

    #TODO: Isto deverá ser removido em versões posteriores
    describe "GET #index" do
        it "returns a success response" do
            get :index, params: {}
            expect(response).to be_successful
        end
    end

    describe "GET #show" do
        before {
            @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
        }

        it "returns a success response" do
            get :show, params: {email: @existing_profile.email}
            expect(response).to be_successful
        end
    end

    describe "GET #new" do
        it "returns a success response" do
            get :new, params: {}
            expect(response).to be_successful
        end
    end

    describe "GET #edit" do
        before {
            @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
        }

        it "returns a success response" do
            get :edit, params: { email: @existing_profile.email }
            expect(response).to be_successful
        end
    end

    describe "POST #create" do
        context "with valid params" do
            it "creates a new Profile" do
                expect {
                    post :create, params: { profile: valid_attributes}
                }.to change(Profile, :count).by(1)

            end

            it "redirects to the profile main page" do
                post :create, params: { profile: valid_attributes}

                expect(response).to redirect_to(profile_path(email: valid_attributes[:email] ))
            end
        end

        context "with invalid params" do
            it "doesn't creates a new Profile" do
                expect {
                    post :create, params: { profile: invalid_attributes}
                }.to_not change(Profile, :count)
            end

            it "stay in the new profile" do
                post :create, params: { profile: invalid_attributes}
                expect(response).to render_template(:new)
            end

        end

        context "with a profile with the same email address" do
            before {
                @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
            }

            it "doesn't creates a new Profile" do
                expect {
                    post :create, params: { profile: valid_attributes}
                }.to_not change(Profile, :count)
            end

            it "stay in the new profile" do
                post :create, params: { profile: valid_attributes}
                expect(response).to render_template(:new)
            end
        end
    end
    describe "PUT #update" do
        before {
            @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
            @original_email = @existing_profile.email
            @original_firstname = @existing_profile.firstname
            @original_lastname = @existing_profile.lastname
        }

        context "with valid params" do
            let(:new_attributes) {
                {
                    birthdate: '1999-12-21',
                    sex: 'male',
                    gender: 'Male'
                }
            }

            it "updates the requested profile" do
                put :update, params: {email: @existing_profile.email, profile: new_attributes}
                @existing_profile.reload

                expect(@existing_profile.birthdate.to_date).to eq(new_attributes[:birthdate].to_date)
                expect(@existing_profile.sex).to eq(new_attributes[:sex])
                expect(@existing_profile.gender).to eq(new_attributes[:gender])

            end

            it "does not change the fields email, firstname and lastname" do
                put :update, params: {email: @existing_profile.email, profile: new_attributes}
                @existing_profile.reload

                expect(@existing_profile.email).to eq(@original_email)
                expect(@existing_profile.firstname).to eq(@original_firstname)
                expect(@existing_profile.lastname).to eq(@original_lastname)
            end

            it "stay in the edit profile page" do
                put :update, params: {email: @existing_profile.email, profile: new_attributes}
                expect(response).to render_template(:edit)
            end
        end

        context "with invalid params" do
            let(:invalid_new_attributes) {
                { birthdate: '' }
            }

            let(:invalid_new_attributes_trying_to_replace) {
                {
                    email: "teste@example.org",
                    firstname: "teste",
                    lastname: "sauro"
                }
            }

            it "doesn't update the requested profile with invalid parameter" do
                put :update, params: {email: @existing_profile.email, profile: invalid_new_attributes}
                @existing_profile.reload

                expect(@existing_profile.birthdate.to_date).to_not eq(invalid_new_attributes[:birthdate])
            end

            it "stay in the edit profile" do
                put :update, params: {email: @existing_profile.email, profile: invalid_new_attributes}
                expect(response).to render_template(:edit)
            end

            it "does not change the fields email, firstname and lastname even when passed as params" do
                put :update, params: {email: @existing_profile.email, profile: invalid_new_attributes_trying_to_replace}
                @existing_profile.reload

                expect(@existing_profile.email).to eq(@original_email)
                expect(@existing_profile.firstname).to eq(@original_firstname)
                expect(@existing_profile.lastname).to eq(@original_lastname)
            end
        end
    end

end
