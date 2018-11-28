# frozen_string_literal: true

class PlateletsController < ApplicationController
  layout 'internal'

  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @platelets = @profile.platelets
  end

  def new; end

  def edit
    @platelet = Platelet.find(params[:id])
  end

  def create
    @platelet = Platelet.new(platelet_params)

    @platelet.profile = @profile

    if @platelet.save
      flash[:success] = 'Platelet registered sucessfully'
      redirect_to profile_platelets_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @platelet = Platelet.find(params[:id])

    if @platelet.update(platelet_params)
      flash[:success] = 'Platelet updated sucessfully'
      redirect_to profile_platelets_path(profile_email: @platelet.profile.email)
    else
      render 'edit'
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
    params.require(:platelet).permit(:erythrocyte, :hemoglobin, :hematocrit, :vcm, :hcm, :chcm, :rdw,
                                     :leukocytep, :neutrophilp, :eosinophilp, :basophilp, :lymphocytep,
                                     :monocytep, :leukocyteul, :neutrophilul, :eosinophilul, :basophilul,
                                     :lymphocyteul, :monocyteul, :total)
  end
end
