require 'rails_helper'

RSpec.describe HealthInsurancesController, type: :controller do
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

    it 'returns a page with all health insurances registered from an user' do
      get :index, params: { profile_email: @existing_profile.email }
      expect(assigns(:health_insurances)).to eq(@existing_profile.health_insurances)
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

    it 'render a new health insurance page' do
      get :new, params: { profile_email: @existing_profile.email }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      @existing_health_insurance = FactoryBot.create :health_insurance, profile: @existing_profile
    end

    it 'returns a success response' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_health_insurance.id }
      expect(response).to be_successful
    end

    it 'returns an existing health insurance' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_health_insurance.id }
      expect(assigns(:health_insurance)).to eq(@existing_health_insurance)
    end

    it 'returns an edit view' do
      get :edit, params: { profile_email: @existing_profile.email,
                           id: @existing_health_insurance.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      let(:valid_attributes) do
        { name: 'My current and favorite health insurance', 
          provider: 'Medidata My Health',
          plan_name: 'Full 200',
          plan_number: '201700123456',
          plan_type: 'Medical',
          start_date: 1.day.ago,
          expiration_date: 1.year.since }
      end

      it 'creates a new Health Insurance' do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            health_insurance: valid_attributes
          }
        end.to change(@existing_profile.health_insurances, :count).by(1)
      end

      it 'redirects to the health insurances page' do
        post :create, params: {
          profile_email: @existing_profile.email,
          health_insurance: valid_attributes
        }

        expect(response).to redirect_to(
          profile_health_insurances_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        { name: '', 
          provider: '',
          plan_name: '',
          plan_number: '',
          plan_type: '',
          start_date: ''}

      end

      it "doesn't creates a new health insurance" do
        expect do
          post :create, params: {
            profile_email: @existing_profile.email,
            health_insurance: invalid_attributes
          }
        end.to_not change(@existing_profile.health_insurances, :count)
      end

      it 'stay in the new health insurance' do
        post :create, params: {
          profile_email: @existing_profile.email,
          health_insurance: invalid_attributes
        }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @existing_health_insurance = FactoryBot.create :health_insurance, profile: @existing_profile
      @original_health_insurance = @existing_health_insurance.clone
    end

    context 'with valid params' do
      let(:new_attributes) do
        { name: 'My current and favorite health insurance', 
          provider: 'Medidata My Health',
          plan_name: 'Full 200',
          plan_number: '201700123456',
          plan_type: 'Medical',
          start_date: 1.day.ago,
          expiration_date: 1.year.since}
      end

      it 'updates the requested profile' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_health_insurance.id,
                               health_insurance: new_attributes }
        @existing_health_insurance.reload

        expect(@existing_health_insurance.name).to eq(new_attributes[:name])
        expect(@existing_health_insurance.provider).to eq(new_attributes[:provider])
        expect(@existing_health_insurance.plan_name).to eq(new_attributes[:plan_name])
        expect(@existing_health_insurance.plan_number).to eq(new_attributes[:plan_number])
        expect(@existing_health_insurance.plan_type).to eq(new_attributes[:plan_type])
        expect(@existing_health_insurance.start_date).to eq(new_attributes[:start_date].to_date)
        expect(@existing_health_insurance.expiration_date).to eq(new_attributes[:expiration_date].to_date)
        expect(@existing_health_insurance.profile).to eq(@existing_profile)
      end

      it 'redirects to the health insurances page' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_health_insurance.id,
                               health_insurance: new_attributes }

        expect(response).to redirect_to(
          profile_health_insurances_path(profile_email: @existing_profile.email)
        )
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
         { name: '', 
          provider: '',
          plan_name: '',
          plan_number: '',
          plan_type: '',
          start_date: ''}
      end

      it "doesn't change the Health Insurance" do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_health_insurance.id,
                               health_insurance: invalid_attributes }
        @existing_health_insurance.reload
        expect(@existing_health_insurance.name).to eq(@original_health_insurance.name)
        expect(@existing_health_insurance.provider).to eq(@original_health_insurance.provider)
        expect(@existing_health_insurance.plan_name).to eq(@original_health_insurance.plan_name)
        expect(@existing_health_insurance.plan_number).to eq(@original_health_insurance.plan_number)
        expect(@existing_health_insurance.plan_type).to eq(@original_health_insurance.plan_type)
        expect(@existing_health_insurance.start_date).to eq(@original_health_insurance.start_date)
        expect(@existing_health_insurance.expiration_date).to eq(@original_health_insurance.expiration_date)
        expect(@existing_health_insurance.profile).to eq(@existing_profile)
      end

      it 'stay in the edit health insurance' do
        put :update, params: { profile_email: @existing_profile.email,
                               id: @existing_health_insurance.id,
                               health_insurance: invalid_attributes }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @existing_health_insurance = FactoryBot.create :health_insurance, profile: @existing_profile
    end

    it 'destroys the requested health insurance' do
      expect do
        delete :destroy, params: { profile_email: @existing_profile.email,
                                   id: @existing_health_insurance.to_param }
      end.to change(HealthInsurance, :count).by(-1)
    end

    it 'redirects to the health insurances list' do
      delete :destroy, params: { profile_email: @existing_profile.email,
                                 id: @existing_health_insurance.to_param }
      expect(response).to redirect_to(
        profile_health_insurances_path(profile_email: @existing_profile.email)
      )
    end
  end

end
