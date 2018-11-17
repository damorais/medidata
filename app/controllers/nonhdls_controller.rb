# frozen_string_literal: true
class NonhdlsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @nonhdls = @profile.non_hdls
  end

  def new; end

  def edit
    @non_hdl = NonHdl.find(params[:id])
  end

  def create
    @non_hdl = NonHdl.new(nonhdl_params)

    @non_hdl.profile = @profile

    if @non_hdl.save
      flash[:success] = 'Non-HDL Cholesterol registered sucessfully'
      redirect_to profile_nonhdls_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @non_hdl = NonHdl.find(params[:id])

    if @non_hdl.update(nonhdl_params)
      flash[:success] = 'Non-HDL Cholesterol updated sucessfully'
      redirect_to profile_nonhdls_path(profile_email: @non_hdl.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @non_hdl = NonHdl.find(params[:id])

    profile_email = @non_hdl.profile.email

    @non_hdl.destroy

    redirect_to profile_nonhdls_path(profile_email: profile_email)
  end

  private

  def nonhdl_params
    params.require(:non_hdl).permit(:value, :date)
  end
end
