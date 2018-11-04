class PlateletController < ApplicationController
  before_action :recover_profile

  def index
    @platelets = @profile.medications
  end

  def new
  end

  def edit
    @platelet = Medication.find(params[:id])
  end

  def create
    @platelet = Medication.new(platelet_params)

    @platelet.profile = @profile

    if @platelet.save
      flash[:success] = "Platelet registered sucessfully"
      redirect_to profile_platelets_path(profile_email: @profile.email)
    else
      render "new"
    end
  end

  def update
    @platelet = Platelet.find(params[:id])

    if @platelet.update(platelet_params)
      flash[:success] = "Platelet updated sucessfully"
      redirect_to profile_platelets_path(profile_email: @platelet.profile.email)
    else
      render "edit"
    end
  end

  def destroy
    @platelet = Platelet.find(params[:id])

    profile_email = @platelet.profile.email

    @platelet.destroy

    redirect_to profile_platelets_path(profile_email: profile_email)
  end

  private

  def platelet_params
    params.require(:platelet).permit(:name, :categorize, :start, :finish, :dosage, :infadd)
  end
end
