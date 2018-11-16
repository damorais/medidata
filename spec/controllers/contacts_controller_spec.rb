# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
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

    it 'returns a page with all contacts registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:contacts)).to eq(@existing_profile.contacts)
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

    it 'render a new contact page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_contact = FactoryBot.create :contact, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_contact.id }
      expect(response).to be_successful
    end

    it 'returns an existing contact' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_contact.id }
      expect(assigns(:contact)).to eq(@existing_contact)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_contact.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { email: 'antonio@exemplo.org',
          name: 'Antonio',
          phone: '1129291121',
          mobile: '11981812828' }
      end

      it 'creates a new Contact' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            contact: valid_attributes
          }
        end.to change(@existing_profile.contacts, :count).by(1)
      end

      it 'redirects to the contacts page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          contact: valid_attributes
        }

        expect(response).to redirect_to(
          profile_contacts_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { email: '', name: '', phone: '', mobile: '' }
      end

      it "doesn't creates a new Contact" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            contact: invalid_attributes
          }
        end.to_not change(@existing_profile.contacts, :count)
      end

      it 'stay in the new contact' do
        post :create, params: {
          profile_email: @existing_profile.email,
          contact: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_contact = FactoryBot.create :contact, profile: @existing_profile
      @original_contact_email = @existing_contact.email
      @original_contact_name = @existing_contact.name
      @original_contact_phone = @existing_contact.phone
      @original_contact_mobile = @existing_contact.mobile
    end

    context 'with valid params' do
      let(:new_attributes) do
        { email: 'petrus@exemplo.org',
          name: 'Petrus',
          phone: '1120201323',
          mobile: '11982838128' }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_contact.id,
                               contact: new_attributes }
        @existing_contact.reload

        expect(@existing_contact.email).to eq(new_attributes[:email])
        expect(@existing_contact.name).to eq(new_attributes[:name])
        expect(@existing_contact.phone).to eq(new_attributes[:phone])
        expect(@existing_contact.mobile).to eq(new_attributes[:mobile])
        expect(@existing_contact.profile).to eq(@existing_profile)
      end

      it 'redirects to the contacts page' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_contact.id,
                               contact: new_attributes }

        expect(response).to redirect_to(
          profile_contacts_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { email: '', name: '', phone: '', mobile: '' }
      end

      it "doesn't change the Contact" do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_contact.id,
                               contact: invalid_attributes }
        @existing_contact.reload

        expect(@existing_contact.email).to eq(@original_contact_email)
        expect(@existing_contact.name).to eq(@original_contact_name)
        expect(@existing_contact.phone).to eq(@original_contact_phone)
        expect(@existing_contact.mobile).to eq(@original_contact_mobile)
        expect(@existing_contact.profile).to eq(@existing_profile)
      end

      it 'stay in the edit contact' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_contact.id,
                               contact: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_contact = FactoryBot.create :contact, profile: @existing_profile
    end

    it 'destroys the requested contact' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email,
                                   id: @existing_contact.to_param }
      end.to change(Contact, :count).by(-1)
    end

    it 'redirects to the contact list' do
      delete :destroy, params: { profile_email: @existing_profile.email,
                                 id: @existing_contact.to_param }
      expect(response).to redirect_to(
        profile_contacts_path(profile_email: @existing_profile.email)
      )
    end
  end
end
