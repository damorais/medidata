# frozen_string_literal: true

require 'factory_bot'
require 'rails_helper'

RSpec.describe MedicationsController, type: :controller do
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

    it 'returns a page with all medications registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:medications)).to eq(@existing_profile.medications)
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

    it 'render a new Medication page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_medication = FactoryBot.create :medication, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
      expect(response).to be_successful
    end

    it 'returns an existing medication' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
      expect(assigns(:medication)).to eq(@existing_medication)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_medication.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { name: 'aspirina',
          categorize: 'powder',
          start: '2018-01-01',
          finish: '2019-01-01',
          dosage: 'teste',
          infadd: 'blabla' }
      end

      it 'creates a new Medication' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            medication: valid_attributes
          }
        end.to change(@existing_profile.medications, :count).by(1)
      end

      it 'redirects to the medications page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          medication: valid_attributes
        }
        expect(response).to redirect_to(
          profile_medications_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', categorize: '', start: '', finish: '', dosage: '' }
      end

      it "doesn't creates a new medication" do
        expect do
          post :create, params: {
<<<<<<< HEAD
            profile_email: @existing_profile.email,
            medication: invalid_attributes
          }
        end.to_not change(@existing_profile.heights, :count)
=======
                          profile_email: @existing_profile.email,
                          medication: invalid_attributes,
                        }
        }.to_not change(@existing_profile.medications, :count)
>>>>>>> Inclusao dos testes unitatios rspec
      end

      it 'stay in the new medication' do
        post :create, params: {
          profile_email: @existing_profile.email,
          medication: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_medication = FactoryBot.create :medication, profile: @existing_profile
      @original_medication_name = @existing_medication.name
      @original_medication_categorize = @existing_medication.categorize
      @original_medication_start = @existing_medication.start
      @original_medication_finish = @existing_medication.finish
      @original_medication_dosage = @existing_medication.dosage
      @original_medication_infadd = @existing_medication.infadd
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'dipirona',
          categorize: 'inalavel',
          start: '2018-01-03',
          finish: '2019-01-03',
          dosage: 'test',
          infadd: 'info adicionais'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_medication.id,
                               medication: new_attributes }
        @existing_medication.reload

        expect(@existing_medication.name).to eq(new_attributes[:name])
        expect(@existing_medication.categorize).to eq(new_attributes[:categorize])
        expect(@existing_medication.start).to eq(new_attributes[:start].to_date)
        expect(@existing_medication.finish).to eq(new_attributes[:finish].to_date)
        expect(@existing_medication.dosage).to eq(new_attributes[:dosage])
        expect(@existing_medication.infadd).to eq(new_attributes[:infadd])
        expect(@existing_medication.profile).to eq(@existing_profile)
      end

      it 'redirects to the medications page' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_medication.id,
                               medication: new_attributes }

        expect(response).to redirect_to(
          profile_medications_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '',
          categorize: '',
          start: '',
          finish: '',
          dosage: '',
          infadd: '' }
      end

      it "doesn't change the Medication" do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_medication.id,
                               medication: invalid_attributes }
        @existing_medication.reload

        expect(@existing_medication.name).to eq(@original_medication_name)
        expect(@existing_medication.categorize).to eq(@original_medication_categorize)
        expect(@existing_medication.start).to eq(@original_medication_start)
        expect(@existing_medication.finish).to eq(@original_medication_finish)
        expect(@existing_medication.dosage).to eq(@original_medication_dosage)
        expect(@existing_medication.infadd).to eq(@original_medication_infadd)
        expect(@existing_medication.profile).to eq(@existing_profile)
      end

      it 'stay in the edit medication' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_medication.id,
                               medication: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_medication = FactoryBot.create :medication, profile: @existing_profile
    end

    it 'destroys the requested medications' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email,
                                   id: @existing_medication.to_param }
      end.to change(Medication, :count).by(-1)
    end

    it 'redirects to the medications list' do
      delete :destroy, params: { profile_email: @existing_profile.email,
                                 id: @existing_medication.to_param }
      expect(response).to redirect_to(
        profile_medications_path(profile_email: @existing_profile.email)
      )
    end
  end
end
