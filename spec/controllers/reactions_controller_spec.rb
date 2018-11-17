# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
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

    it 'returns a page with all reactions registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:reactions)).to eq(@existing_profile.reactions)
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

    it 'render a new reaction page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_reaction = FactoryBot.create :reaction, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_reaction.id }
      expect(response).to be_successful
    end

    it 'returns an existing reaction' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_reaction.id }
      expect(assigns(:reaction)).to eq(@existing_reaction)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email, id: @existing_reaction.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        { name: 'Buscopan', cause: 'Medication', description: 'Tontura', start: '2018-06-25', finish: 1.day.ago }
      end

      it 'creates a new Reaction ' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            reaction: valid_attributes
          }
        end.to change(@existing_profile.reactions, :count).by(1)
      end

      it 'redirects to the reactions page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          reaction: valid_attributes
        }

        expect(response).to redirect_to(profile_reactions_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', cause: '', description: '' }
      end

      it "doesn't creates a new Reaction" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            reaction: invalid_attributes
          }
        end.to_not change(@existing_profile.reactions, :count)
      end

      it 'stay in the new reaction' do
        post :create, params: {
          profile_email: @existing_profile.email,
          reaction: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_reaction = FactoryBot.create :reaction, profile: @existing_profile
      @original_reaction_name = @existing_reaction.name
      @original_reaction_cause = @existing_reaction.cause
      @original_reaction_description = @existing_reaction.description
      @original_reaction_start = @existing_reaction.start
      @original_reaction_finish = @existing_reaction.finish
    end

    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Buscopan', cause: 'Medication', description: 'Tontura', start: '2018-06-25', finish: 1.day.ago }
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_reaction.id, reaction: new_attributes }
        @existing_reaction.reload

        expect(@existing_reaction.name).to eq(new_attributes[:name])
        expect(@existing_reaction.cause).to eq(new_attributes[:cause])
        expect(@existing_reaction.description).to eq(new_attributes[:description])
        expect(@existing_reaction.start).to eq(new_attributes[:start].to_date)
        expect(@existing_reaction.finish).to eq(new_attributes[:finish].to_date)
        expect(@existing_reaction.profile).to eq(@existing_profile)
      end

      it 'redirects to the reactions page' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_reaction.id, reaction: new_attributes }

        expect(response).to redirect_to(profile_reactions_path(profile_email: @existing_profile.email))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', cause: '', description: '' }
      end

      it "doesn't change the Reaction" do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_reaction.id, reaction: invalid_attributes }
        @existing_reaction.reload

        expect(@existing_reaction.name).to eq(@original_reaction_name)
        expect(@existing_reaction.cause).to eq(@original_reaction_cause)
        expect(@existing_reaction.description).to eq(@original_reaction_description)
        expect(@existing_reaction.profile).to eq(@existing_profile)
      end

      it 'stay in the edit reaction' do
        put :update, params: { profile_email: @existing_profile.email, id: @existing_reaction.id, reaction: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_reaction = FactoryBot.create :reaction, profile: @existing_profile
    end

    it 'destroys the requested reaction' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_reaction.to_param }
      end.to change(Reaction, :count).by(-1)
    end

    it 'redirects to the reaction list' do
      delete :destroy, params: { profile_email: @existing_profile.email, id: @existing_reaction.to_param }
      expect(response).to redirect_to(profile_reactions_path(profile_email: @existing_profile.email))
    end
  end
end
