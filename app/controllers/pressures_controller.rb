class PressuresController < ApplicationController
  layout 'internal'
  
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @pressures = @profile.pressures
  end

  def new; end

  def edit
    @pressure = Pressure.find_by(id: params[:id])
  end

  def create
    @pressure = Pressure.new(pressure_params)
    @pressure.profile = @profile

    if @pressure.save
      flash[:success] = 'Blood pressure registered successfully'
      @pressures = @profile.pressures
      redirect_to profile_pressures_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @pressure = Pressure.find_by(id: params[:id])

    if @pressure.update(pressure_params)
      flash[:success] = 'Blood pressure was changed successfully'
      redirect_to profile_pressures_path(profile_email: @pressure.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @pressure = Pressure.find(params[:id])

    if @pressure.destroy
      flash[:success] = 'Blood pressure successfully excluded'
    end
    redirect_to action: :index
  end

  private

  def pressure_params
    params.require(:pressure).permit(:systolic,
                                     :diastolic,
                                     :date)
  end
end
