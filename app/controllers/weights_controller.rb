class WeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @weights = @profile.weights
  end

  def new; end

  def edit
    @weight = Weight.find(params[:id])
  end

  def create
    @weight = Weight.new(weight_params)

    @weight.profile = @profile

    if @weight.save
      flash[:success] = 'Weight registered sucessfully'
      redirect_to profile_weights_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @weight = Weight.find(params[:id])

    if @weight.update(weight_params)
      flash[:success] = 'Weight updated sucessfully'
      redirect_to profile_weights_path(profile_email: @weight.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @weight = Weight.find(params[:id])

    profile_email = @weight.profile.email

    @weight.destroy

    redirect_to profile_weights_path(profile_email: profile_email)
  end

  private

  def weight_params
    params.require(:weight).permit(:value, :date)
  end
end
