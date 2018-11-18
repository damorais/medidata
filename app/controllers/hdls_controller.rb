# frozen_string_literal: true

class HdlsController < ApplicationController
  layout 'internal'
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @hdls = @profile.hdls
  end

  def new; end

  def edit
    @hdl = Hdl.find(params[:id])
  end

  def create
    @hdl = Hdl.new(hdl_params)

    @hdl.profile = @profile

    if @hdl.save
      flash[:success] = 'HDL Cholesterol registered sucessfully'
      redirect_to profile_hdls_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @hdl = Hdl.find(params[:id])

    if @hdl.update(hdl_params)
      flash[:success] = 'HDL Cholesterol updated sucessfully'
      redirect_to profile_hdls_path(profile_email: @hdl.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @hdl = Hdl.find(params[:id])

    profile_email = @hdl.profile.email

    @hdl.destroy

    redirect_to profile_hdls_path(profile_email: profile_email)
  end

  private

  def hdl_params
    params.require(:hdl).permit(:value, :date)
  end
end
