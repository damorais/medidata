require 'rails_helper'

RSpec.describe RelativesController, type: :controller do

 # Todo registro de familiar depende de um perfil válido existente
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

        it "returns a page with all relatives registered from an user" do
            get :index, params: { profile_email: @existing_profile.email }
            expect(assigns(:relatives)).to eq(@existing_profile.relatives)
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
        
        it "render a new relative page" do
            get :new, params: { profile_email: @existing_profile.email }
            expect(response).to render_template(:new)
        end

    end

    describe "GET #edit" do
        before { 
            @existing_relative = FactoryBot.create :relative, :profile => @existing_profile
        }
        
        it "returns a success response" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_relative.id }
            expect(response).to be_successful
        end

        it "returns an existing relative" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_relative.id }
            expect(assigns(:relative)).to eq(@existing_relative)
        end

        it "returns an edit view" do  
            get :edit, params: { profile_email: @existing_profile.email, id: @existing_relative.id }
            expect(response).to render_template(:edit)
        end

    end

    describe "POST #create" do

        context "with valid params" do
            let(:valid_attributes) { 
                { name: "João", description: "Pressão Alta" }
            }

            it "creates a new Relative " do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        relative: valid_attributes 
                    } 
                }.to change(@existing_profile.relatives, :count).by(1)
            end
            
            it "redirects to the relatives page" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    relative: valid_attributes 
                }
                
                expect(response).to redirect_to(profile_relatives_path(profile_email: @existing_profile.email))
            end

        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't creates a new Relative" do
                expect {
                    post :create, params: { 
                        profile_email: @existing_profile.email, 
                        relative: invalid_attributes 
                    }
                }.to_not change(@existing_profile.relatives, :count)
            end

            it "stay in the new relative" do
                post :create, params: { 
                    profile_email: @existing_profile.email, 
                    relative: invalid_attributes 
                }
                
                expect(response).to render_template(:new)
            end

        end
    end

    describe "PUT #update" do
        before { 
            @existing_relative = FactoryBot.create :relative, :profile => @existing_profile
            @original_relative_name = @existing_relative.name
            @original_relative_description = @existing_relative.description
        }

        context "with valid params" do
            let(:new_attributes) {
               	{ name: "João", description: "Pressão Alta" }	
            }

            it "updates the requested profile" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_relative.id, relative: new_attributes}
                @existing_relative.reload
                
                expect(@existing_relative.name).to eq(new_attributes[:name])
				expect(@existing_relative.description).to eq(new_attributes[:description])
                expect(@existing_relative.profile).to eq(@existing_profile)
            end

            it "redirects to the relatives page" do
                put :update, params: { profile_email: @existing_profile.email, id: @existing_relative.id, relative: new_attributes }
                
                expect(response).to redirect_to(profile_relatives_path(profile_email: @existing_profile.email))
            end
        end

        context "with invalid params" do
            let(:invalid_attributes) { 
                { name: "", description: "" }
            }

            it "doesn't change the Relative" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_relative.id, relative: invalid_attributes}
                @existing_relative.reload
                expect(@existing_relative.name).to eq(@original_relative_name)
				expect(@existing_relative.description).to eq(@original_relative_description)
                expect(@existing_relative.profile).to eq(@existing_profile)
            end

            it "stay in the edit relative" do
                put :update, params: {profile_email: @existing_profile.email, id: @existing_relative.id, relative: invalid_attributes}
                
                expect(response).to render_template(:edit)
            end
        end
    end

    describe "DELETE #destroy" do
        before { 
            @existing_relative = FactoryBot.create :relative, :profile => @existing_profile
        }

        it "destroys the requested relative" do
            expect {
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_relative.to_param}
            }.to change(Relative, :count).by(-1)
        end

        it "redirects to the relative list" do
            delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_relative.to_param}
            expect(response).to redirect_to(profile_relatives_path(profile_email: @existing_profile.email))
        end

    end


end
