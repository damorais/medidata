# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HdlsController, type: :controller do
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

    it 'returns a page with all hdls registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:hdls)).to eq(@existing_profile.hdls)
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

    it 'render a new hdl page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_hdl = FactoryBot.create :hdl, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_hdl.id }
      expect(response).to be_successful
    end

    it 'returns an existing hdl' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_hdl.id }
      expect(assigns(:hdl)).to eq(@existing_hdl)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_hdl.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { value: '70', date: 1.day.ago }
      end

      it 'creates a new hdl' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            hdl: valid_attributes
          }
        end.to change(@existing_profile.hdls, :count).by(1)
      end

      it 'redirects to the hdls page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          hdl: valid_attributes
        }

        expect(response).to redirect_to(profile_hdls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't creates a new hdl" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            hdl: invalid_attributes
          }
        end.to_not change(@existing_profile.hdls, :count)
      end

      it 'stay in the new hdl' do
        post :create, params: {
          profile_email: @existing_profile.email,
          hdl: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_hdl = FactoryBot.create :hdl, profile: @existing_profile
      @original_hdl_value = @existing_hdl.value
      @original_hdl_date = @existing_hdl.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '121',
          date: '2018-10-25'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_hdl.id, hdl: new_attributes }
        @existing_hdl.reload

        expect(@existing_hdl.value).to eq(new_attributes[:value].to_f)
        expect(@existing_hdl.date).to eq(new_attributes[:date].to_date)
        expect(@existing_hdl.profile).to eq(@existing_profile)
      end

      it 'redirects to the hdls page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_hdl.id, hdl: new_attributes }

        expect(response).to redirect_to(profile_hdls_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't change the hdl" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_hdl.id, hdl: invalid_attributes }
        @existing_hdl.reload

        expect(@existing_hdl.value).to eq(@original_hdl_value)
        expect(@existing_hdl.date).to eq(@original_hdl_date)
        expect(@existing_hdl.profile).to eq(@existing_profile)
      end

      it 'stay in the edit hdl' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_hdl.id, hdl: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_hdl = FactoryBot.create :hdl, profile: @existing_profile
    end

    it 'destroys the requested hdl' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_hdl.to_param }
      end.to change(Hdl, :count).by(-1)
    end

    it 'redirects to the hdls list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_hdl.to_param }
      expect(response).to redirect_to(profile_hdls_path(profile_email: @existing_profile.email))
    end
  end
end
