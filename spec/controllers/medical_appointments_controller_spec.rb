require 'rails_helper'
require 'date'

RSpec.describe MedicalAppointmentsController, type: :controller do
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org', user: @user
    end

    after do
      sign_out @user
    end

    describe 'GET #index' do
      it 'returns a success response' do
        get :index, params: { profile_email: @existing_profile.email }
        expect(response).to be_successful
      end

      it 'returns a page with all medical appointments registered from an user' do
        get :index, params: { profile_email: @existing_profile.email }
        expect(assigns(:medical_appointments)).to eq(@existing_profile.medical_appointments)
      end

      it 'render a index page' do
        get :index, params: { profile_email: @existing_profile.email }
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new, params: { profile_email: @existing_profile.email }
        expect(response).to be_successful
      end

      it 'render a new medical appointment page' do
        get :new, params: { profile_email: @existing_profile.email }
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      before do
        @existing_appointment = FactoryBot.create :medical_appointment, profile: @existing_profile
      end

      it 'returns a success response' do
        get :edit, params: { profile_email: @existing_profile.email, id: @existing_appointment.id }
        expect(response).to be_successful
      end

      it 'returns an existing medical appointment' do
        get :edit, params: { profile_email: @existing_profile.email, id: @existing_appointment.id }
        expect(assigns(:medical_appointment)).to eq(@existing_appointment)
      end

      it 'returns an edit view' do
        get :edit, params: { profile_email: @existing_profile.email, id: @existing_appointment.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        let(:valid_attributes) do
          {
            specialty: "cardiologist", address: "Av. Paulista", professional: "dr. Joao" , note: 'phone', date: DateTime.now
          }
        end

        it 'creates a new medical appointment' do
          expect do
            post :create, params: {
              profile_email: @existing_profile.email,
              medical_appointment: valid_attributes
            }
          end.to change(@existing_profile.medical_appointments, :count).by(1)
        end

        it 'redirects to the medical appointments page' do
          post :create, params: {
            profile_email: @existing_profile.email,
            medical_appointment: valid_attributes
          }

          expect(response).to redirect_to(profile_medical_appointments_path(profile_email: @existing_profile.email))
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) do
          {
            specialty: " ", address: "Av. Paulista", professional: "dr. Joao" , note: 'phone', date: DateTime.now
          }
        end

        it "doesn't creates a new medical appointment" do
          expect do
            post :create, params: {
              profile_email: @existing_profile.email,
              medical_appointment: invalid_attributes
            }
          end.to_not change(@existing_profile.medical_appointments, :count)
        end

        it 'stay in the new medical appointment' do
          post :create, params: {
            profile_email: @existing_profile.email,
            medical_appointment: invalid_attributes
          }

          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #update' do
      before do
        @existing_appointment = FactoryBot.create :medical_appointment, profile: @existing_profile
        @original_appointment_specialty = @existing_appointment.specialty
        @original_appointment_address = @existing_appointment.address
        @original_appointment_professional = @existing_appointment.professional
        @original_appointment_note = @existing_appointment.note
        @original_appointment_date = @existing_appointment.date
      end

      context 'with valid params' do
        let(:new_attributes) do
          {
            specialty: "cardiologist",
            address: "Av. Paulista",
            professional: "dr. Joao",
            note: 'phone',
            date: DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
          }
        end

        it 'updates the requested profile' do
          put :update, params: {
            profile_email: @existing_profile.email,
            id: @existing_appointment.id,
            medical_appointment: new_attributes
          }
          @existing_appointment.reload

          expect(@existing_appointment.specialty).to eq(new_attributes[:specialty])
          expect(@existing_appointment.address).to eq(new_attributes[:address])
          expect(@existing_appointment.professional).to eq(new_attributes[:professional])
          expect(@existing_appointment.date).to eq(new_attributes[:date])
          expect(@existing_appointment.note).to eq(new_attributes[:note])

        end

        it 'redirects to the medical appointments page' do
          put :update, params: {
            profile_email: @existing_profile.email, id: @existing_appointment.id,
            medical_appointment: new_attributes
          }

          expect(response).to redirect_to(profile_medical_appointments_path(profile_email: @existing_profile.email))
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) do
          {
            specialty: '',
            address: "Av. Paulista",
            professional: "dr. Joao",
            note: 'phone',
            date: DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
          }
        end

        it "doesn't change the medical appointment" do
          put :update, params: {
            profile_email: @existing_profile.email,
            id: @existing_appointment.id,
            medical_appointment: invalid_attributes
          }
          @existing_appointment.reload

          expect(@existing_appointment.specialty).to eq(@original_appointment_specialty)
          expect(@existing_appointment.address).to eq(@original_appointment_address)
          expect(@existing_appointment.note).to eq(@original_appointment_note)
          expect(@existing_appointment.date).to eq(@original_appointment_date)
          expect(@existing_appointment.profile).to eq(@existing_profile)
        end

        it 'stay in the edit medical appointment' do
          put :update, params: {
            profile_email: @existing_profile.email,
            id: @existing_appointment.id,
            medical_appointment: invalid_attributes
          }

          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        @existing_appointment = FactoryBot.create :medical_appointment, profile: @existing_profile
      end

      it 'destroys the requested' do
        expect do
          delete :destroy, params: {
            profile_email: @existing_profile.email,
            id: @existing_appointment.to_param
          }
        end.to change(MedicalAppointment, :count).by(-1)
      end

      it 'redirects to the medical appointments list' do
        delete :destroy, params: {
          profile_email: @existing_profile.email,
          id: @existing_appointment.to_param
        }
        expect(response).to redirect_to(profile_medical_appointments_path(profile_email: @existing_profile.email))
      end
    end
  end
