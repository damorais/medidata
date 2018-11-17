# frozen_string_literal: true

class VldlsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @vldls = @profile.vldls
  end

  def new; end

  def edit
    @vldl = Vldl.find(params[:id])
  end

  def create
    @vldl = Vldl.new(vldl_params)

    @vldl.profile = @profile

    if @vldl.save
      flash[:success] = 'VLDL Cholesterol registered sucessfully'
      redirect_to profile_vldls_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @vldl = Vldl.find(params[:id])

    if @vldl.update(vldl_params)
      flash[:success] = 'VLDL Cholesterol updated sucessfully'
      redirect_to profile_vldls_path(profile_email: @vldl.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @vldl = Vldl.find(params[:id])

    profile_email = @vldl.profile.email

    @vldl.destroy

    redirect_to profile_vldls_path(profile_email: profile_email)
  end

  private

  def vldl_params
    params.require(:vldl).permit(:value, :date)
  end
end
