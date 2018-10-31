require 'rails_helper'

RSpec.describe NonhdlsController, type: :controller do
    # Todo registro de Non-HDL depende de um perfil válido existente
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "returns a page with all non_hdls registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:nonhdls)).to eq(@existing_profile.non_hdls)
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

        it "render a new non_hdl page" do
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
            @existing_non_hdl = FactoryBot.create :non_hdl, :profile => @existing_profile
        }
        
        it "returns a success response" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_non_hdl.id }
            expect(response).to be_successful
        end

        it "returns an existing non_hdl" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_non_hdl.id }
            expect(assigns(:non_hdl)).to eq(@existing_non_hdl)
        end

        it "returns an edit view" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_non_hdl.id }
            expect(response).to render_template(:edit)
        end
        
        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :edit, params: { profile_email: "inexisting_user@example.org", id: @existing_non_hdl.id }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "POST #create" do

        it "returns an error when trying to access based on inexisting user" do
            expect{
                post :create, params: { 
                    profile_email: "inexisting_user@example.org", 
                    non_hdl: {} 
                }
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:valid_attributes) { 
                { value: "70", date: 1.day.ago }
            }

            it "creates a new non_hdl" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        non_hdl: valid_attributes 
                    } 
                }.to change(@existing_profile.non_hdls, :count).by(1)
            end
            
            it "redirects to the non_hdls page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    non_hdl: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_nonhdls_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { value: "" }
            }

            it "doesn't creates a new non_hdl" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        non_hdl: invalid_attributes 
                    }
                }.to_not change(@existing_profile.non_hdls, :count)
            end

            it "stay in the new non_hdl" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    non_hdl: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end
        end
    end

    describe "PUT #update" do
        before { 
            @existing_non_hdl = FactoryBot.create :non_hdl, :profile => @existing_profile
            @original_non_hdl_value = @existing_non_hdl.value
            @original_non_hdl_date = @existing_non_hdl.date
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                put :update, params: {profile_email: "inexisting_user@example.org", id: @existing_non_hdl.id, non_hdl: {}}
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:new_attributes) {
                {
                    value: '149',
                    date: '2018-10-25'
                }
            }

            it "updates the requested profile" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_non_hdl.id, non_hdl: new_attributes}
                @existing_non_hdl.reload
                
                expect(@existing_non_hdl.value).to eq(new_attributes[:value].to_f)
                expect(@existing_non_hdl.date).to eq(new_attributes[:date].to_date)
                expect(@existing_non_hdl.profile).to eq(@existing_profile)
            end

            it "redirects to the non_hdls page" do
                put :update, params: { profile_email: @existing_profile.email, id: @existing_non_hdl.id, non_hdl: new_attributes }
                
                expect(response).to redirect_to(profile_nonhdls_path(profile_email: @existing_profile.email))
            end

        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { value: "" }
            }

            it "doesn't change the non_hdl" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_non_hdl.id, non_hdl: invalid_attributes}
                @existing_non_hdl.reload
                
                expect(@existing_non_hdl.value).to eq(@original_non_hdl_value)
                expect(@existing_non_hdl.date).to eq(@original_non_hdl_date)
                expect(@existing_non_hdl.profile).to eq(@existing_profile)
            end

            it "stay in the edit non_hdl" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_non_hdl.id, non_hdl: invalid_attributes}
                
                expect(response).to render_template(:edit)
            end

        end

    end

    describe "DELETE #destroy" do
        before { 
            @existing_non_hdl = FactoryBot.create :non_hdl, :profile => @existing_profile
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                delete :destroy, params: {profile_email: "inexisting_user@example.org", id: @existing_non_hdl.to_param}
            }.to raise_error(ActionController::RoutingError)
        end

        it "destroys the requested non_hdl" do
            expect {
                delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_non_hdl.to_param}
            }.to change(NonHdl, :count).by(-1)
        end

        it "redirects to the non_hdls list" do
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_non_hdl.to_param}
            expect(response).to redirect_to(profile_nonhdls_path(profile_email: @existing_profile.email))
        end
    end
end