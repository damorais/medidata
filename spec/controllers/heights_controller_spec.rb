require 'rails_helper'

RSpec.describe HeightsController, type: :controller do
    # Todo registro de altura depende de um perfil válido existente
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "returns a page with all heights registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:heights)).to eq(@existing_profile.heights)
        end

        it "render a index page" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to render_template(:index)
        end
        
        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :index, params: { profile_email: "inexisting_user@example.org" }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "GET #new" do
        it "returns a success response" do
            get :new, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "render a new height page" do
            get :new, params: { profile_email: @existing_profile.email }
            expect(response).to render_template(:new)
        end

        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :new, params: { profile_email: "inexisting_user@example.org" }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "GET #edit" do
        before { 
            @existing_height = FactoryBot.create :height, :profile => @existing_profile
        }
        
        it "returns a success response" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_height.id }
            expect(response).to be_successful
        end

        it "returns an existing height" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_height.id }
            expect(assigns(:height)).to eq(@existing_height)
        end

        it "returns an edit view" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_height.id }
            expect(response).to render_template(:edit)
        end
        
        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :edit, params: { profile_email: "inexisting_user@example.org", id: @existing_height.id }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "POST #create" do

        it "returns an error when trying to access based on inexisting user" do
            expect{
                post :create, params: { 
                    profile_email: "inexisting_user@example.org", 
                    height: {} 
                }
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:valid_attributes) { 
                { value: "70", date: 1.day.ago }
            }

            it "creates a new Height" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        height: valid_attributes 
                    } 
                }.to change(@existing_profile.heights, :count).by(1)
            end
            
            it "redirects to the heights page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    height: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_heights_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { value: "" }
            }

            it "doesn't creates a new height" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        height: invalid_attributes 
                    }
                }.to_not change(@existing_profile.heights, :count)
            end

            it "stay in the new height" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    height: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end
        end
    end

    describe "PUT #update" do
        before { 
            @existing_height = FactoryBot.create :height, :profile => @existing_profile
            @original_height_value = @existing_height.value
            @original_height_date = @existing_height.date
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                put :update, params: {profile_email: "inexisting_user@example.org", id: @existing_height.id, height: {}}
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:new_attributes) {
                {
                    value: '1.85',
                    date: '2018-06-25'
                }
            }

            it "updates the requested profile" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_height.id, height: new_attributes}
                @existing_height.reload
                
                expect(@existing_height.value).to eq(new_attributes[:value].to_f)
                expect(@existing_height.date).to eq(new_attributes[:date].to_date)
                expect(@existing_height.profile).to eq(@existing_profile)
            end

            it "redirects to the heights page" do
                put :update, params: { profile_email: @existing_profile.email, id: @existing_height.id, height: new_attributes }
                
                expect(response).to redirect_to(profile_heights_path(profile_email: @existing_profile.email))
            end

        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { value: "" }
            }

            it "doesn't change the Height" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_height.id, height: invalid_attributes}
                @existing_height.reload
                
                expect(@existing_height.value).to eq(@original_height_value)
                expect(@existing_height.date).to eq(@original_height_date)
                expect(@existing_height.profile).to eq(@existing_profile)
            end

            it "stay in the edit height" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_height.id, height: invalid_attributes}
                
                expect(response).to render_template(:edit)
            end

        end

    end

    describe "DELETE #destroy" do
        before { 
            @existing_height = FactoryBot.create :height, :profile => @existing_profile
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                delete :destroy, params: {profile_email: "inexisting_user@example.org", id: @existing_height.to_param}
            }.to raise_error(ActionController::RoutingError)
        end

        it "destroys the requested beight" do
            expect {
                delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_height.to_param}
            }.to change(Height, :count).by(-1)
        end

        it "redirects to the heights list" do
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_height.to_param}
            expect(response).to redirect_to(profile_heights_path(profile_email: @existing_profile.email))
        end
    end
end