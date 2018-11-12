require 'rails_helper'

RSpec.describe PlateletsController, type: :controller do

  # Todo registro de peso depende de um perfil válido existente
  before {
    @existing_profile = FactoryBot.create :profile, :email => "joao@example.org"
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {profile_email: @existing_profile.email}
      expect(response).to be_successful
    end

    it "returns a page with all platelets registered from an user" do
      get :index, params: {profile_email: @existing_profile.email}
      expect(assigns(:platelets)).to eq(@existing_profile.platelets)
    end

    it "render a index page" do
      get :index, params: {profile_email: @existing_profile.email}
      expect(response).to render_template(:index)
    end

    it "returns an error when trying to access based on inexisting user" do
      expect {
        get :index, params: {profile_email: "inexisting_user@example.org"}
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {profile_email: @existing_profile.email}
      expect(response).to be_successful
    end

    it "render a new Platelets page" do
      get :new, params: {profile_email: @existing_profile.email}
      expect(response).to render_template(:new)
    end

    it "returns an error when trying to access based on inexisting user" do
      expect {
        get :new, params: {profile_email: "inexisting_user@example.org"}
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET #edit" do
    before {
      @existing_platelet = FactoryBot.create :platelet, :profile => @existing_profile
    }

    it "returns a success response" do
      get :edit, params: {profile_email: @existing_profile.email, id: @existing_platelet.id}
      expect(response).to be_successful
    end

    it "returns an existing medication" do
      get :edit, params: {profile_email: @existing_profile.email, id: @existing_platelet.id}
      expect(assigns(:platelet)).to eq(@existing_platelet)
    end

    it "returns an edit view" do
      get :edit, params: {profile_email: @existing_profile.email, id: @existing_platelet.id}
      expect(response).to render_template(:edit)
    end

    it "returns an error when trying to access based on inexisting user" do
      expect {
        get :edit, params: {profile_email: "inexisting_user@example.org", id: @existing_platelet.id}
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "POST #create" do
    it "returns an error when trying to access based on inexisting user" do
      expect {
        post :create, params: {
                        profile_email: "inexisting_user@example.org",
                        platelet: {},
                      }
      }.to raise_error(ActionController::RoutingError)
    end

    context "with valid params" do
      let(:valid_attributes) {
        {erythrocyte: 1, hemoglobin: 2, hematocrit:3, vcm:4, hcm:5, chcm:6, rdw:7, leukocytep:8, neutrophilp:9, eosinophilp:10,
         basophilp:11, lymphocytep:12,  monocytep:13, leukocyteul:14, neutrophilul:15, eosinophilul:16, basophilul:17,
         lymphocyteul:18, monocyteul:19, total:20}
      }

      it "creates a new Platelet Register" do
        expect {
          post :create, params: {
                          profile_email: @existing_profile.email,
                          platelet: valid_attributes,
                        }
        }.to change(@existing_profile.platelets, :count).by(1)
      end

      it "redirects to the platelets page" do
        post :create, params: {
                        profile_email: @existing_profile.email,
                        platelet: valid_attributes,
                      }
        expect(response).to redirect_to(profile_platelets_path(profile_email: @existing_profile.email))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) {
          {erythrocyte: "", hemoglobin:"", hematocrit:"", vcm:"", hcm:"", chcm:"", rdw:"", leukocytep:"", neutrophilp:"", eosinophilp:"",
           basophilp:"", lymphocytep:"",  monocytep:"", leukocyteul:"", neutrophilul:"", eosinophilul:"", basophilul:"",
           lymphocyteul:"", monocyteul:"", total:""}
        }

      it "doesn't creates a new platelets" do
        expect {
          post :create, params: {
                          profile_email: @existing_profile.email,
                          platelet: invalid_attributes,
                        }
        }.to_not change(@existing_profile.platelets, :count)
      end

      it "stay in the new platelets" do
        post :create, params: {
                        profile_email: @existing_profile.email,
                        platelet: invalid_attributes,
                      }

        expect(response).to render_template(:new)
      end
    end
  end


end
