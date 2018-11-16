# frozen_string_literal: true

require 'factory_bot'
require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:valid_attributes) do
    {
      email: 'joao@example.org',
      firstname: 'João',
      lastname: 'Silva',
      birthdate: '2000-12-15'
    }
  end

  let(:invalid_attributes) do
    {
      email: '',
      firstname: '',
      lastname: '',
      birthdate: ''
    }
  end

  # TODO: Isto devera ser removido em versões posteriores
  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    after do
      sign_out @user
    end

    it 'returns a success response' do
      get :show, params: { email: @existing_profile.email }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
    end

    after do
      sign_out @user
    end

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
    end

    after do
      sign_out @user
    end

    it 'returns a success response' do
      get :edit, params: { email: @existing_profile.email }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      @user = FactoryBot.create :user, email: valid_attributes[:email]
      sign_in @user
    end

    after do
      sign_out @user
    end

    context 'with valid params' do
      it 'creates a new Profile' do
        expect do
          post :create, params: { profile: valid_attributes }
        end.to change(Profile, :count).by(1)
      end

      it 'redirects to the profile main page' do
        post :create, params: { profile: valid_attributes }

        expect(response).to redirect_to(profile_path(email: valid_attributes[:email]))
      end
    end

    context 'with invalid params' do
      it "doesn't creates a new Profile" do
        expect do
          post :create, params: { profile: invalid_attributes }
        end.to_not change(Profile, :count)
      end

      it 'stay in the new profile' do
        post :create, params: { profile: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end

    context 'with a profile with the same email address' do
      before do
        @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
      end

      it "doesn't creates a new Profile" do
        expect do
          post :create, params: { profile: valid_attributes }
        end.to_not change(Profile, :count)
      end

      it 'stay in the new profile' do
        post :create, params: { profile: valid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @user = FactoryBot.create :user, email: 'joao@example.org'
      sign_in @user
      @existing_profile = FactoryBot.create :profile, email: 'joao@example.org'
      @original_email = @existing_profile.email
      @original_firstname = @existing_profile.firstname
      @original_lastname = @existing_profile.lastname
    end

    after do
      sign_out @user
    end

    context 'with valid params' do
      let(:new_attributes) do
        {
          birthdate: '1999-12-21',
          sex: 'male',
          gender: 'Male'
        }
      end

      it 'updates the requested profile' do
        put :update, params: { email: @existing_profile.email,
                               profile: new_attributes }
        @existing_profile.reload

        expect(@existing_profile.birthdate.to_date).to eq(new_attributes[:birthdate].to_date)
        expect(@existing_profile.sex).to eq(new_attributes[:sex])
        expect(@existing_profile.gender).to eq(new_attributes[:gender])
      end

      it 'does not change the fields email, firstname and lastname' do
        put :update, params: { email: @existing_profile.email,
                               profile: new_attributes }
        @existing_profile.reload

        expect(@existing_profile.email).to eq(@original_email)
        expect(@existing_profile.firstname).to eq(@original_firstname)
        expect(@existing_profile.lastname).to eq(@original_lastname)
      end

      it 'stay in the edit profile page' do
        put :update, params: { email: @existing_profile.email,
                               profile: new_attributes }
        expect(response).to render_template(:edit)
      end
    end

    context 'with invalid params' do
      let(:invalid_new_attributes) do
        { birthdate: '' }
      end

      let(:invalid_new_attributes_trying_to_replace) do
        {
          email: 'teste@example.org',
          firstname: 'teste',
          lastname: 'sauro'
        }
      end

      it "doesn't update the requested profile with invalid parameter" do
        put :update, params: { email: @existing_profile.email,
                               profile: invalid_new_attributes }
        @existing_profile.reload

        expect(@existing_profile.birthdate.to_date).to_not eq(
          invalid_new_attributes[:birthdate]
        )
      end

      it 'stay in the edit profile' do
        put :update, params: { email: @existing_profile.email, profile: invalid_new_attributes }
        expect(response).to render_template(:edit)
      end

      it 'does not change the fields email, firstname and lastname even when passed as params' do
        put :update, params: { email: @existing_profile.email,
                               profile: invalid_new_attributes_trying_to_replace }
        @existing_profile.reload

        expect(@existing_profile.email).to eq(@original_email)
        expect(@existing_profile.firstname).to eq(@original_firstname)
        expect(@existing_profile.lastname).to eq(@original_lastname)
      end
    end
  end
end
