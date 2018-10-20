require 'rails_helper'

RSpec.describe PressuresController, type: :controller do

  before  {
       @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
  }

  describe "GET #index" do
      it "returns a success response" do
          get :index, params: { profile_email: @existing_profile.email }
          expect(response).to be_successful
      end

      it "returns a page with all pressures registered from an user" do
          get :index, params: { profile_email: @existing_profile.email }
          expect(assigns(:pressures)).to eq(@existing_profile.pressures)
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

      it "render a new pressure page" do
          get :new, params: { profile_email: @existing_profile.email }
          expect(response).to render_template(:new)
      end
  end


    describe "GET #edit" do
          before {
              @existing_pressure = FactoryBot.create :pressure, :profile => @existing_profile
          }

          it "returns a success response" do
              get :edit, params: {profile_email: @existing_profile.email, id: @existing_pressure.id }
              expect(response).to be_successful
          end

          it "returns an existing pressure" do
              get :edit, params: {profile_email: @existing_profile.email, id: @existing_pressure.id }
              expect(assigns(:pressure)).to eq(@existing_pressure)
          end

          it "returns an edit view" do
              get :edit, params: {profile_email: @existing_profile.email, id: @existing_pressure.id }
              expect(response).to render_template(:edit)
          end
      end


      describe "POST #create" do

          context "with valid params" do
              let(:valid_attributes) {
                  { diastolic: "10", systolic: "80", date: 1.day.ago }
              }

              it "creates a new Pressure" do
                  expect {
                      post :create, params: {
                          profile_email: @existing_profile.email,
                          pressure: valid_attributes
                      }
                  }.to change(@existing_profile.pressures , :count).by(1)
              end

              it "redirects to the Pressure page" do
                  post :create, params: {
                      profile_email: @existing_profile.email,
                      pressure: valid_attributes
                  }

                  expect(response).to redirect_to(profile_pressures_path(profile_email: @existing_profile.email))
              end
          end
        end

          context "with invalid params" do
              let(:invalid_attributes) {
                  {  diastolic: "", systolic: "80", date: 1.day.ago  }
              }

              it "doesn't creates a new pressure" do
                  expect {
                      post :create, params: {
                          profile_email: @existing_profile.email,
                          pressure: invalid_attributes
                      }
                  }.to_not change(@existing_profile.pressures, :count)
              end

              it "stay in the new pressure" do
                  post :create, params: {
                      profile_email: @existing_profile.email,
                      pressure: invalid_attributes
                  }

                  expect(response).to render_template(:new)
              end
          end

          describe "DELETE #destroy" do
              before {
                  @existing_pressure = FactoryBot.create :pressure, :profile => @existing_profile
              }

              it "destroys the requested pressure" do
                  expect {
                      delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_pressure.to_param}
                  }.to change(Pressure, :count).by(-1)
              end
              it "redirects to the pressures list" do
                  delete :destroy, params: {profile_email: @existing_profile.email, id: @existing_pressure.to_param}
                  expect(response).to redirect_to(profile_pressures_path(profile_email: @existing_profile.email))
              end
          end

          describe "PUT #update" do
              before {
                  @existing_pressure = FactoryBot.create :pressure, :profile => @existing_profile
                  @original_pressure_systolic = @existing_pressure.systolic
                  @original_pressure_diastolic = @existing_pressure.diastolic
                  @original_pressure_date = @existing_pressure.date
              }

              context "with valid params" do
                let(:new_attributes) {
                    { diastolic: "11", systolic: "22", date: "2018-10-18 11:58:22" }
                }

                  it "updates the requested profile" do
                      put :update, params: {profile_email: @existing_profile.email, id: @existing_pressure.id, pressure: new_attributes}
                      @existing_pressure.reload

                      expect(@existing_pressure.systolic).to eq(new_attributes[:systolic].to_i)
                      expect(@existing_pressure.diastolic).to eq(new_attributes[:diastolic].to_i)
                      expect(@existing_pressure.date).to eq(new_attributes[:date].to_datetime)
                      expect(@existing_pressure.profile).to eq(@existing_profile)
                  end

                  it "redirects to the pressure page" do
                      put :update, params: { profile_email: @existing_profile.email, id: @existing_pressure.id, pressure: new_attributes }
                      expect(response).to redirect_to(profile_pressures_path(profile_email: @existing_profile.email))
                  end

              end

              context "with invalid params" do
                  let(:invalid_attributes) {
                      {diastolic: "-2", systolic: "-1", date: "2018-10-18 11:58:22"}
                  }

                  it "doesn't change the Pressure" do
                      put :update, params: {profile_email: @existing_profile.email, id: @existing_pressure.id, pressure: invalid_attributes}
                      @existing_pressure.reload

                      expect(@existing_pressure.systolic).to eq(@original_pressure_systolic)
                      expect(@existing_pressure.diastolic).to eq(@original_pressure_diastolic)
                      expect(@existing_pressure.date).to eq(@original_pressure_date)
                      expect(@existing_pressure.profile).to eq(@existing_profile)
                  end

                  it "stay in the edit pressure" do
                      put :update, params: {profile_email: @existing_profile.email, id: @existing_pressure.id, pressure: invalid_attributes}
                      expect(response).to render_template(:edit)
                  end

              end

          end


  end
