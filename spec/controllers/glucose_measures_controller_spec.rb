# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe GlucoseMeasuresController, type: :controller do
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

    it 'returns a page with all glucose measures registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:glucose_measures)).to eq(@existing_profile.glucose_measures)
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

    it 'render a new glucose measure page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_glucose = FactoryBot.create :glucose_measure, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_glucose.id }
      expect(response).to be_successful
    end

    it 'returns an existing glucose measure' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_glucose.id }
      expect(assigns(:glucose_measure)).to eq(@existing_glucose)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_glucose.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        {
          fasting: true, value: '100', date: DateTime.now
        }
      end

      it 'creates a new glucose measure' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            glucose_measure: valid_attributes
          }
        end.to change(@existing_profile.glucose_measures, :count).by(1)
      end

      it 'redirects to the glucose measures page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          glucose_measure: valid_attributes
        }

        expect(response).to redirect_to(profile_glucose_measures_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        {
          value: '', fasting: true, date: DateTime.now
        }
      end

      it "doesn't creates a new glucose measure" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            glucose_measure: invalid_attributes
          }
        end.to_not change(@existing_profile.glucose_measures, :count)
      end

      it 'stay in the new glucose measure' do
        post :create, params: {
          profile_email: @existing_profile.email,
          glucose_measure: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_glucose = FactoryBot.create :glucose_measure, profile: @existing_profile
      @original_glucose_value = @existing_glucose.value
      @original_glucose_fasting = @existing_glucose.fasting
      @original_glucose_date = @existing_glucose.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '50',
          fasting: true,
          date: DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
        }
      end

      it 'updates the requested profile' do
        put :update, params: {
          profile_email: @existing_profile.email,
          id: @existing_glucose.id,
          glucose_measure: new_attributes
        }
        @existing_glucose.reload

        expect(@existing_glucose.value).to eq(new_attributes[:value].to_f)
        expect(@existing_glucose.fasting).to eq(new_attributes[:fasting])
        expect(@existing_glucose.date).to eq(new_attributes[:date])
        expect(@existing_glucose.profile).to eq(@existing_profile)
      end

      it 'redirects to the glucose measures page' do
        put :update, params: {
          profile_email: @existing_profile.email, id: @existing_glucose.id,
          glucose_measure: new_attributes
        }

        expect(response).to redirect_to(profile_glucose_measures_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        {
          value: '',
          fasting: true,
          date: DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
        }
      end

      it "doesn't change the glucose measure" do
        put :update, params: {
          profile_email: @existing_profile.email,
          id: @existing_glucose.id,
          glucose_measure: invalid_attributes
        }
        @existing_glucose.reload
        expect(@existing_glucose.value).to eq(@original_glucose_value)
        expect(@existing_glucose.fasting).to eq(@original_glucose_fasting)
        expect(@existing_glucose.date).to eq(@original_glucose_date)
        expect(@existing_glucose.profile).to eq(@existing_profile)
      end

      it 'stay in the edit glucose' do
        put :update, params: {
          profile_email: @existing_profile.email,
          id: @existing_glucose.id,
          glucose_measure: invalid_attributes
        }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_glucose = FactoryBot.create :glucose_measure, profile: @existing_profile
    end

    it 'destroys the requested' do
      expect do
        delete :destroy, params: {
          profile_email: @existing_profile.email,
          id: @existing_glucose.to_param
        }
      end.to change(GlucoseMeasure, :count).by(-1)
    end

    it 'redirects to the glucose measures list' do
      delete :destroy, params: {
        profile_email: @existing_profile.email,
        id: @existing_glucose.to_param
      }
      expect(response).to redirect_to(profile_glucose_measures_path(profile_email: @existing_profile.email))
    end
  end
end
