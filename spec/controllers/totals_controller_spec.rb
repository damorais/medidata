# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TotalsController, type: :controller do
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

    it 'returns a page with all totals registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:totals)).to eq(@existing_profile.totals)
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

    it 'render a new total page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_total = FactoryBot.create :total, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_total.id }
      expect(response).to be_successful
    end

    it 'returns an existing total' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_total.id }
      expect(assigns(:total)).to eq(@existing_total)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_total.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { value: '70', date: 1.day.ago }
      end

      it 'creates a new total' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            total: valid_attributes
          }
        end.to change(@existing_profile.totals, :count).by(1)
      end

      it 'redirects to the totals page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          total: valid_attributes
        }

        expect(response).to redirect_to(profile_totals_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't creates a new total" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            total: invalid_attributes
          }
        end.to_not change(@existing_profile.totals, :count)
      end

      it 'stay in the new total' do
        post :create, params: {
          profile_email: @existing_profile.email,
          total: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_total = FactoryBot.create :total, profile: @existing_profile
      @original_total_value = @existing_total.value
      @original_total_date = @existing_total.date
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          value: '190',
          date: '2018-10-25'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_total.id, total: new_attributes }
        @existing_total.reload

        expect(@existing_total.value).to eq(new_attributes[:value].to_f)
        expect(@existing_total.date).to eq(new_attributes[:date].to_date)
        expect(@existing_total.profile).to eq(@existing_profile)
      end

      it 'redirects to the totals page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_total.id, total: new_attributes }

        expect(response).to redirect_to(profile_totals_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { value: '' }
      end

      it "doesn't change the total" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_total.id, total: invalid_attributes }
        @existing_total.reload

        expect(@existing_total.value).to eq(@original_total_value)
        expect(@existing_total.date).to eq(@original_total_date)
        expect(@existing_total.profile).to eq(@existing_profile)
      end

      it 'stay in the edit total' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_total.id, total: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_total = FactoryBot.create :total, profile: @existing_profile
    end

    it 'destroys the requested total' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_total.to_param }
      end.to change(Total, :count).by(-1)
    end

    it 'redirects to the totals list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_total.to_param }
      expect(response).to redirect_to(profile_totals_path(profile_email: @existing_profile.email))
    end
  end
end
