require 'factory_bot'
require 'rails_helper'

RSpec.describe MedicationsController, type: :controller do
  # Todo registro de peso depende de um perfil válido existente
  before {
      @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
  }

  describe "GET #index" do
      it "returns a success response" do
          get :index, params: { profile_email: @existing_profile.email }
          expect(response).to be_successful
      end

      it "returns a page with all medications registered from an user" do
          get :index, params: { profile_email: @existing_profile.email }
          expect(assigns(:medications)).to eq(@existing_profile.medications)
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

      it "render a new Medication page" do
          get :new, params: { profile_email: @existing_profile.email }
          expect(response).to render_template(:new)
      end
  end

  describe "GET #edit" do
      before {
          @existing_medication = FactoryBot.create :medication, :profile => @existing_profile
      }

      it "returns a success response" do
          get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
          expect(response).to be_successful
      end

      it "returns an existing medication" do
          get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
          expect(assigns(:medication)).to eq(@existing_medication)
      end

      it "returns an edit view" do
          get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
          expect(response).to render_template(:edit)
      end
  end

  describe "POST #create" do

      context "with valid params" do
          let(:valid_attributes) {
              { name: "aspirina", categorize: "powder", start: "2018-01-01", finish:"2019-01-01", dosage:"teste", infadd:"blabla" }
          }

          it "creates a new Medication" do
              expect {
                  post :create, params: {
                      profile_email: @existing_profile.email,
                      medication: valid_attributes
                  }
              }.to change(@existing_profile.medications, :count).by(1)
          end

          it "redirects to the medications page" do
              post :create, params: {
                  profile_email: @existing_profile.email,
                  medication: valid_attributes
              }
              expect(response).to redirect_to(profile_medications_path(profile_email: @existing_profile.email))
          end
      end

  end

  describe "PUT #update" do
      before {
          @existing_medication = FactoryBot.create :medication, :profile => @existing_profile
          @original_medication_name = @existing_medication.name
          @original_medication_categorize = @existing_medication.categorize
          @original_medication_start = @existing_medication.start
          @original_medication_finish = @existing_medication.finish
          @original_medication_dosage = @existing_medication.dosage
          @original_medication_infadd = @existing_medication.infadd

      }

      context "with valid params" do
          let(:new_attributes) {
              {
                  name: "dipirona",
                  categorize: "inalavel",
                  start: "2018-01-03",
                  finish: "2019-01-03",
                  dosage: "test",
                  infadd: "info adicionais"
              }
          }

          it "updates the requested profile" do
              put :update, params: {profile_email: @existing_profile.email, id: @existing_medication.id, medication: new_attributes}
              @existing_medication.reload

              expect(@existing_medication.name).to eq(new_attributes[:name])
              expect(@existing_medication.categorize).to eq(new_attributes[:categorize])
              expect(@existing_medication.start).to eq(new_attributes[:start].to_date)
              expect(@existing_medication.finish).to eq(new_attributes[:finish].to_date)
              expect(@existing_medication.dosage).to eq(new_attributes[:dosage])
              expect(@existing_medication.infadd).to eq(new_attributes[:infadd])
              expect(@existing_medication.profile).to eq(@existing_profile)
          end

          it "redirects to the medications page" do
              put :update, params: { profile_email: @existing_profile.email, id: @existing_medication.id, medication: new_attributes }

              expect(response).to redirect_to(profile_medications_path(profile_email: @existing_profile.email))
          end

      end

      context "with invalid params" do
          let(:invalid_attributes) {
              { name: '',
                categorize: '',
                start: '',
                finish: '',
                dosage: '',
                infadd: '' }
          }

          it "doesn't change the Medication" do
              put :update, params: {profile_email: @existing_profile.email, id: @existing_medication.id, medication: invalid_attributes}
              @existing_medication.reload

              expect(@existing_medication.name).to eq(@original_medication_name)
              expect(@existing_medication.categorize).to eq(@original_medication_categorize)
              expect(@existing_medication.start).to eq(@original_medication_start)
              expect(@existing_medication.finish).to eq(@original_medication_finish)
              expect(@existing_medication.dosage).to eq(@original_medication_dosage)
              expect(@existing_medication.infadd).to eq(@original_medication_infadd)
              expect(@existing_medication.profile).to eq(@existing_profile)


          end

          it "stay in the edit medication" do
              put :update, params: {profile_email: @existing_profile.email, id: @existing_medication.id, medication: invalid_attributes}

              expect(response).to render_template(:edit)
          end

      end
  end

  describe "DELETE #destroy" do
      before {
          @existing_medication = FactoryBot.create :medication, :profile => @existing_profile
      }

      it "destroys the requested medications" do
          expect {
          delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_medication.to_param}
        }.to change(Medication, :count).by(-1)
      end

      it "redirects to the medications list" do
          delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_medication.to_param}
          expect(response).to redirect_to(profile_medications_path(profile_email: @existing_profile.email))
      end
  end

end
