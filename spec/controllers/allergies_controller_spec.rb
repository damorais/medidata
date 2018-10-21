require 'rails_helper'

RSpec.describe AllergiesController, type: :controller do
   # Todo registro de alergia depende de um perfil válido existente
    before { 
        @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
    } 

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "returns a page with all allergies registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:allergies)).to eq(@existing_profile.allergies)
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

        it "render a new allergy page" do
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
            @existing_allergy = FactoryBot.create :allergy, :profile => @existing_profile
        }
        
        it "returns a success response" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_allergy.id }
            expect(response).to be_successful
        end

        it "returns an existing allergy" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_allergy.id }
            expect(assigns(:allergy)).to eq(@existing_allergy)
        end

        it "returns an edit view" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_allergy.id }
            expect(response).to render_template(:edit)
        end

        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :edit, params: { profile_email: "inexisting_user@example.org", id: @existing_allergy.id }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "POST #create" do

        it "returns an error when trying to access based on inexisting user" do
            expect{
                post :create, params: { 
                    profile_email: "inexisting_user@example.org", 
                    allergy: {}
                } 
                
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:valid_attributes) { 
                { name: "Buscopan", description: "Dipirona Sódica" }
            }

            it "creates a new Allergy " do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        allergy: valid_attributes 
                    } 
                }.to change(@existing_profile.allergies, :count).by(1)
            end
            
            it "redirects to the allergies page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    allergy: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_allergies_path(profile_email: @existing_profile.email))
            end

        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't creates a new Allergy" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        allergy: invalid_attributes 
                    }
                }.to_not change(@existing_profile.allergies, :count)
            end

            it "stay in the new allergy" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    allergy: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end

        end
    end

    describe "PUT #update" do
        before { 
            @existing_allergy = FactoryBot.create :allergy, :profile => @existing_profile
            @original_allergy_name = @existing_allergy.name
            @original_allergy_description = @existing_allergy.description
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                put :update, params: {profile_email: "inexisting_user@example.org", id: @existing_allergy.id, allergy: {}}
            }.to raise_error(ActionController::RoutingError)
        end
        
        context "with valid params" do
            let(:new_attributes) {
               	{ name: "Buscopan", description: "Princípio Ativo: Dipirona Sódica" }	
            }

            it "updates the requested profile" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_allergy.id, allergy: new_attributes}
                @existing_allergy.reload
                
                expect(@existing_allergy.name).to eq(new_attributes[:name])
				expect(@existing_allergy.description).to eq(new_attributes[:description])
                expect(@existing_allergy.profile).to eq(@existing_profile)
            end

            it "redirects to the allergies page" do
                put :update, params: { profile_email: @existing_profile.email, id: @existing_allergy.id, allergy: new_attributes }
                
                expect(response).to redirect_to(profile_allergies_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't change the Allergy" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_allergy.id, allergy: invalid_attributes}
                @existing_allergy.reload
                
                expect(@existing_allergy.name).to eq(@original_allergy_name)
				expect(@existing_allergy.description).to eq(@original_allergy_description)
                expect(@existing_allergy.profile).to eq(@existing_profile)
            end

            it "stay in the edit allergy" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_allergy.id, allergy: invalid_attributes}
                
                expect(response).to render_template(:edit)
            end
        end
    end
	
    describe "DELETE #destroy" do
        before { 
            @existing_allergy = FactoryBot.create :allergy, :profile => @existing_profile
        }

        it "destroys the requested allergy" do
            expect {
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_allergy.to_param}
            }.to change(Allergy, :count).by(-1)
        end

        it "redirects to the allergy list" do
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_allergy.to_param}
            expect(response).to redirect_to(profile_allergies_path(profile_email: @existing_profile.email))
        end

        it "returns an error when trying to access based on inexisting user" do
            expect{
                delete :destroy, params: {profile_email: "inexisting_user@example.org", id: @existing_allergy.to_param}
            }.to raise_error(ActionController::RoutingError)
        end
    end
end