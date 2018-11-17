# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VldlsController, type: :controller do
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

    it 'returns a page with all vldls registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:vldls)).to eq(@existing_profile.vldls)
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

    it 'render a new vldl page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_vldl = FactoryBot.create :vldl, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_vldl.id }
      expect(response).to be_successful
    end

    it 'returns an existing vldl' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_vldl.id }
      expect(assigns(:vldl)).to eq(@existing_vldl)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_vldl.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { value: '70', date: 1.day.ago }
      end

      it 'creates a new vldl' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            vldl: valid_attributes
          }
        end.to change(@existing_profile.vldls, :count).by(1)
      end

      it 'redirects to the vldls page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          vldl: valid_attributes
        }

        expect(response).to redirect_to(profile_vldls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't creates a new vldl" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            vldl: invalid_attributes
          }
        end.to_not change(@existing_profile.vldls, :count)
      end

      it 'stay in the new vldl' do
        post :create, params: {
          profile_email: @existing_profile.email,
          vldl: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_vldl = FactoryBot.create :vldl, profile: @existing_profile
      @original_vldl_value = @existing_vldl.value
      @original_vldl_date = @existing_vldl.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '85',
          date: '2018-10-25'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_vldl.id, vldl: new_attributes }
        @existing_vldl.reload

        expect(@existing_vldl.value).to eq(new_attributes[:value].to_f)
        expect(@existing_vldl.date).to eq(new_attributes[:date].to_date)
        expect(@existing_vldl.profile).to eq(@existing_profile)
      end

      it 'redirects to the vldls page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_vldl.id, vldl: new_attributes }

        expect(response).to redirect_to(profile_vldls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't change the vldl" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_vldl.id, vldl: invalid_attributes }
        @existing_vldl.reload

        expect(@existing_vldl.value).to eq(@original_vldl_value)
        expect(@existing_vldl.date).to eq(@original_vldl_date)
        expect(@existing_vldl.profile).to eq(@existing_profile)
      end

      it 'stay in the edit vldl' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_vldl.id, vldl: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_vldl = FactoryBot.create :vldl, profile: @existing_profile
    end

    it 'destroys the requested vldl' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_vldl.to_param }
      end.to change(Vldl, :count).by(-1)
    end

    it 'redirects to the vldls list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_vldl.to_param }
      expect(response).to redirect_to(profile_vldls_path(profile_email: @existing_profile.email))
    end
  end
end
