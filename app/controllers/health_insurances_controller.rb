class HealthInsurancesController < ApplicationController
  layout 'internal'

  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @health_insurances = @profile.health_insurances
  end

  def new; end

  def edit
    @health_insurance = HealthInsurance.find(params[:id])
  end

  def create
    @health_insurance = HealthInsurance.new(health_insurance_params)

    @health_insurance.profile = @profile

    if @health_insurance.save
      flash[:success] = 'Health insurance registered sucessfully'
      redirect_to profile_health_insurances_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @health_insurance = HealthInsurance.find(params[:id])

    if @health_insurance.update(health_insurance_params)
      flash[:success] = 'Health insurance updated sucessfully'
      redirect_to profile_health_insurances_path(profile_email: @health_insurance.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @health_insurance = HealthInsurance.find(params[:id])

    profile_email = @health_insurance.profile.email

    @health_insurance.destroy

    redirect_to profile_health_insurances_path(profile_email: profile_email)
  end

  private

  def health_insurance_params
    params.require(:health_insurance).permit(:name, :plan_type, :provider, :plan_name, :plan_number, :start_date, :expiration_date)
  end
end
