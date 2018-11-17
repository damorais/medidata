# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe WeightsController, type: :controller do
  before do
    @user = FactoryBot.create :user, email: 'joao@example.org'
    @existing_profile = FactoryBot.create :profile, email: 'joao@example.org', user: @user
    sign_in @user
  end

  after do
    sign_out(@user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(response).to be_successful
    end

    it 'returns a page with all weights registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:weights)).to eq(@existing_profile.weights)
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

    it 'render a new weight page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_weight = FactoryBot.create :weight, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_weight.id }
      expect(response).to be_successful
    end

    it 'returns an existing weight' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_weight.id }
      expect(assigns(:weight)).to eq(@existing_weight)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_weight.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { value: '70', date: 1.day.ago }
      end

      it 'creates a new Weight' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            weight: valid_attributes
          }
        end.to change(@existing_profile.weights, :count).by(1)
      end

      it 'redirects to the weights page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          weight: valid_attributes
        }

        expect(response).to redirect_to(
          profile_weights_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't creates a new Weight" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            weight: invalid_attributes
          }
        end.to_not change(@existing_profile.weights, :count)
      end

      it 'stay in the new weight' do
        post :create, params: {
          profile_email: @existing_profile.email,
          weight: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_weight = FactoryBot.create :weight, profile: @existing_profile
      @original_weight_value = @existing_weight.value
      @original_weight_date = @existing_weight.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '65',
          date: '2018-06-25'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_weight.id,
                               weight: new_attributes }
        @existing_weight.reload

        expect(@existing_weight.value).to eq(new_attributes[:value].to_f)
        expect(@existing_weight.date).to eq(new_attributes[:date].to_date)
        expect(@existing_weight.profile).to eq(@existing_profile)
      end

      it 'redirects to the weights page' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_weight.id,
                               weight: new_attributes }

        expect(response).to redirect_to(
          profile_weights_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't change the Weight" do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_weight.id,
                               weight: invalid_attributes }
        @existing_weight.reload

        expect(@existing_weight.value).to eq(@original_weight_value)
        expect(@existing_weight.date).to eq(@original_weight_date)
        expect(@existing_weight.profile).to eq(@existing_profile)
      end

      it 'stay in the edit weight' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_weight.id,
                               weight: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_weight = FactoryBot.create :weight, profile: @existing_profile
    end

    it 'destroys the requested beight' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email,
                                   id: @existing_weight.to_param }
      end.to change(Weight, :count).by(-1)
    end

    it 'redirects to the weights list' do
      delete :destroy, params: { profile_email: @existing_profile.email,
                                 id: @existing_weight.to_param }
      expect(response).to redirect_to(
        profile_weights_path(profile_email: @existing_profile.email)
      )
    end
  end
end
