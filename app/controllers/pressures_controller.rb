class PressuresController < ApplicationController
  def new
  end

  def index
    @pressures = Pressure.all
  end

  def create
      @profile = Profile.find_by(email: params[:profile_email])
      @pressure = Pressure.new(pressure_create_params)
      @pressure.profile = @profile

      if @pressure.save
        flash[:success] = "Blood pressure registered successfully"
        @pressures = @profile.pressures
        redirect_to profile_pressures_path(profile_email: @profile.email)
      else
        render 'new'
      end
  end

  def edit
    @pressure = Pressure.find_by(id: params[:id])
  end

  def update
    @pressure = Pressure.find_by(id: params[:id])

    if @pressure.update(pressure_update_params)
      flash[:success] = "Blood pressure was changed successfully"
      redirect_to profile_pressures_path(profile_email: @pressure.profile.email)
    else
      render 'edit'
    end


  end

  def destroy
    @pressure = Pressure.find(params[:id])

    if @pressure.destroy
      flash[:success] = "Blood pressure successfully excluded"
    end
    redirect_to action: :index
  end

  private
  def pressure_create_params
    params.require(:pressure  ).permit(:systolic,
                                    :diastolic,
                                    :date)
  end

  private
  def pressure_update_params
    params.require(:pressure).permit(:systolic,
                                    :diastolic,
                                    :date)
  end
end
