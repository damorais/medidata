# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LdlsController, type: :controller do
  before do
    @user = FactoryBot.create :user, email: 'joao@example.org'
    sign_in @user
    @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
  end

  after do
    sign_out @user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(response).to be_successful
    end

    it 'returns a page with all ldls registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:ldls)).to eq(@existing_profile.ldls)
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

    it 'render a new ldl page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_ldl = FactoryBot.create :ldl, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_ldl.id }
      expect(response).to be_successful
    end

    it 'returns an existing ldl' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_ldl.id }
      expect(assigns(:ldl)).to eq(@existing_ldl)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_ldl.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { value: '70', date: 1.day.ago }
      end

      it 'creates a new ldl' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            ldl: valid_attributes
          }
        end.to change(@existing_profile.ldls, :count).by(1)
      end

      it 'redirects to the ldls page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          ldl: valid_attributes
        }

        expect(response).to redirect_to(profile_ldls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't creates a new ldl" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            ldl: invalid_attributes
          }
        end.to_not change(@existing_profile.ldls, :count)
      end

      it 'stay in the new ldl' do
        post :create, params: {
          profile_email: @existing_profile.email,
          ldl: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_ldl = FactoryBot.create :ldl, profile: @existing_profile
      @original_ldl_value = @existing_ldl.value
      @original_ldl_date = @existing_ldl.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '90',
          date: '2018-10-25'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_ldl.id, ldl: new_attributes }
        @existing_ldl.reload

        expect(@existing_ldl.value).to eq(new_attributes[:value].to_f)
        expect(@existing_ldl.date).to eq(new_attributes[:date].to_date)
        expect(@existing_ldl.profile).to eq(@existing_profile)
      end

      it 'redirects to the ldls page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_ldl.id, ldl: new_attributes }

        expect(response).to redirect_to(profile_ldls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't change the ldl" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_ldl.id, ldl: invalid_attributes }
        @existing_ldl.reload

        expect(@existing_ldl.value).to eq(@original_ldl_value)
        expect(@existing_ldl.date).to eq(@original_ldl_date)
        expect(@existing_ldl.profile).to eq(@existing_profile)
      end

      it 'stay in the edit ldl' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_ldl.id, ldl: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_ldl = FactoryBot.create :ldl, profile: @existing_profile
    end

    it 'destroys the requested ldl' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_ldl.to_param }
      end.to change(Ldl, :count).by(-1)
    end

    it 'redirects to the ldls list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_ldl.to_param }
      expect(response).to redirect_to(profile_ldls_path(profile_email: @existing_profile.email))
    end
  end
end
