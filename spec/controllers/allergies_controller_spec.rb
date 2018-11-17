# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AllergiesController, type: :controller do
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

    it 'returns a page with all allergies registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:allergies)).to eq(@existing_profile.allergies)
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

    it 'render a new allergy page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_allergy = FactoryBot.create :allergy, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, 
                           id: @existing_allergy.id }
      expect(response).to be_successful
    end

    it 'returns an existing allergy' do
      get :edit, params: { profile_email: @existing_profile.email, 
                           id: @existing_allergy.id }
      expect(assigns(:allergy)).to eq(@existing_allergy)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, 
                           id: @existing_allergy.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { name: 'Buscopan', description: 'Dipirona Sódica' }
      end

      it 'creates a new Allergy' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            allergy: valid_attributes
          }
        end.to change(@existing_profile.allergies, :count).by(1)
      end

      it 'redirects to the allergies page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          allergy: valid_attributes
        }

        expect(response).to redirect_to(
          profile_allergies_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', description: '' }
      end

      it 'doesnt creates a new Allergy' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            allergy: invalid_attributes
          }
        end.to_not change(@existing_profile.allergies, :count)
      end

      it 'stay in the new allergy' do
        post :create, params: {
          profile_email: @existing_profile.email,
          allergy: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_allergy = FactoryBot.create :allergy, profile: @existing_profile
      @original_allergy_name = @existing_allergy.name
      @original_allergy_description = @existing_allergy.description
    end

    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Buscopan', description: 'Princípio Ativo: Dipirona Sódica' }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, 
                               id: @existing_allergy.id,
                               allergy: new_attributes }
        @existing_allergy.reload

        expect(@existing_allergy.name).to eq(new_attributes[:name])
        expect(@existing_allergy.description).to eq(new_attributes[:description])
        expect(@existing_allergy.profile).to eq(@existing_profile)
      end

      it 'redirects to the allergies page' do
        put :update, params: { profile_email: @existing_profile.email, 
                               id: @existing_allergy.id,
                               allergy: new_attributes }

        expect(response).to redirect_to(
          profile_allergies_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', description: '' }
      end

      it 'doesnt change the Allergy' do
        put :update, params: { profile_email: @existing_profile.email, 
                               id: @existing_allergy.id, 
                               allergy: invalid_attributes }

        @existing_allergy.reload

        expect(@existing_allergy.name).to eq(@original_allergy_name)
        expect(@existing_allergy.description).to eq(@original_allergy_description)
        expect(@existing_allergy.profile).to eq(@existing_profile)
      end

      it 'stay in the edit allergy' do
        put :update, params: { profile_email: @existing_profile.email, 
                               id: @existing_allergy.id,
                               allergy: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_allergy = FactoryBot.create :allergy, profile: @existing_profile
    end

    it 'destroys the requested allergy' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email,
                                   id: @existing_allergy.to_param }
      end.to change(Allergy, :count).by(-1)
    end

    it 'redirects to the allergy list' do
      delete :destroy, params: { profile_email: @existing_profile.email,
                                 id: @existing_allergy.to_param }
      expect(response).to redirect_to(
        profile_allergies_path(profile_email: @existing_profile.email))
    end
  end
end
