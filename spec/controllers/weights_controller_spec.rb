require 'rails_helper'

RSpec.describe WeightsController, type: :controller do
    # Todo registro de peso depende de um perfil válido existente
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "returns a page with all weights registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:weights)).to eq(@existing_profile.weights)
        end

        it "render a index page" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to render_template(:index)
        end
    end

    describe "GET #new" do
        it "returns a success response" do
            get :new, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "render a new weight page" do
            get :new, params: { profile_email: @existing_profile.email }
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do

        context "with valid params" do
            let(:valid_attributes) { 
                { value: "70", date: 1.day.ago }
            }

            it "creates a new Weight" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        weight: valid_attributes 
                    } 
                }.to change(@existing_profile.weights, :count).by(1)
            end
            
            it "redirects to the weights page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    weight: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_weights_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { value: "" }
            }

            it "doesn't creates a new Weight" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        weight: invalid_attributes 
                    }
                }.to_not change(@existing_profile.weights, :count)
            end

            it "stay in the new weight" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    weight: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end

        end
    end

end
