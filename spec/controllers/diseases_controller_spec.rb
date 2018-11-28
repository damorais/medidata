require 'rails_helper'

RSpec.describe DiseasesController, type: :controller do
   # Todo registro de doença depende de um perfil válido existente
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org', user: @user
    end

    after do
      sign_out @user
    end

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(response).to be_successful
        end

        it "returns a page with all diseases registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:diseases)).to eq(@existing_profile.diseases)
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

        it "render a new disease page" do
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
            @existing_disease = FactoryBot.create :disease, :profile => @existing_profile
        }
        
        it "returns a success response" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_disease.id }
            expect(response).to be_successful
        end

        it "returns an existing disease" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_disease.id }
            expect(assigns(:disease)).to eq(@existing_disease)
        end

        it "returns an edit view" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_disease.id }
            expect(response).to render_template(:edit)
        end

        it "returns an error when trying to access based on inexisting user" do
            expect{
                get :edit, params: { profile_email: "inexisting_user@example.org", id: @existing_disease.id }
            }.to raise_error(ActionController::RoutingError)
        end
    end

    describe "POST #create" do

        it "returns an error when trying to access based on inexisting user" do
            expect{
                post :create, params: { 
                    profile_email: "inexisting_user@example.org", 
                    disease: {}
                } 
                
            }.to raise_error(ActionController::RoutingError)
        end

        context "with valid params" do
            let(:valid_attributes) { 
                { name: "Cardiaca", description: "Arritmia", start: '2018-06-25', finish: 1.day.ago}
            }

            it "creates a new Disease " do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        disease: valid_attributes 
                    } 
                }.to change(@existing_profile.diseases, :count).by(1)
            end
            
            it "redirects to the diseases page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    disease: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_diseases_path(profile_email: @existing_profile.email))
            end

        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't creates a new Disease" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        disease: invalid_attributes 
                    }
                }.to_not change(@existing_profile.diseases, :count)
            end

            it "stay in the new disease" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    disease: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end

        end
    end

    describe "PUT #update" do
        before { 
            @existing_disease = FactoryBot.create :disease, :profile => @existing_profile
            @original_disease_name = @existing_disease.name
            @original_disease_description = @existing_disease.description
            @original_disease_start = @existing_disease.start
            @original_disease_finish = @existing_disease.finish
        }

        it "returns an error when trying to access based on inexisting user" do
            expect{
                put :update, params: {profile_email: "inexisting_user@example.org", id: @existing_disease.id, disease: {}}
            }.to raise_error(ActionController::RoutingError)
        end
        
        context "with valid params" do
            let(:new_attributes) {
               	{ name: "Cardiaca", description: "Arritmia", start: '2018-06-25', finish: 1.day.ago }	
            }

            it "updates the requested profile" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_disease.id, disease: new_attributes}
                @existing_disease.reload
                
                expect(@existing_disease.name).to eq(new_attributes[:name])
				expect(@existing_disease.description).to eq(new_attributes[:description])
				expect(@existing_disease.start).to eq(new_attributes[:start].to_date)
				expect(@existing_disease.finish).to eq(new_attributes[:finish].to_date)
                expect(@existing_disease.profile).to eq(@existing_profile)
            end

            it "redirects to the diseases page" do
                put :update, params: { profile_email: @existing_profile.email, id: @existing_disease.id, disease: new_attributes }
                
                expect(response).to redirect_to(profile_diseases_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't change the Disease" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_disease.id, disease: invalid_attributes}
                @existing_disease.reload
                expect(@existing_disease.name).to eq(@original_disease_name)
				expect(@existing_disease.description).to eq(@original_disease_description)
                expect(@existing_disease.profile).to eq(@existing_profile)
            end

            it "stay in the edit disease" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_disease.id, disease: invalid_attributes}
                
                expect(response).to render_template(:edit)
            end
        end
    end
	
    describe "DELETE #destroy" do
        before { 
            @existing_disease = FactoryBot.create :disease, :profile => @existing_profile
        }

        it "destroys the requested disease" do
            expect {
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_disease.to_param}
            }.to change(Disease, :count).by(-1)
        end

        it "redirects to the disease list" do
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_disease.to_param}
            expect(response).to redirect_to(profile_diseases_path(profile_email: @existing_profile.email))
        end

        it "returns an error when trying to access based on inexisting user" do
            expect{
                delete :destroy, params: {profile_email: "inexisting_user@example.org", id: @existing_disease.to_param}
            }.to raise_error(ActionController::RoutingError)
        end
    end
end