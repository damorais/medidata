class PressuresController < ApplicationController
  def new
    # @profile = Profile.find_by(email: params[:profile_email])
  end

  def index
    @pressures = Pressure.all
  end

  def create
      @profile = Profile.find_by(email: params[:profile_email])
      @pressure = Pressure.new(pressure_create_params)
      @pressure.profile = @profile

      if @pressure.save
        flash[:success] = "Pressão sanguínea registrada com sucesso!"
        @pressures = @profile.pressures
        render 'index'
      else
        #render plain: params[:pressure].inspect
        render 'new'
      end
  end

  def edit
    @pressure = Pressure.find_by(id: params[:id])
    #@pressure = Pressure.find(params[:id])
    #redirect_to action: :index

  end

  def update
    @pressure = Pressure.find_by(id: params[:id])

    if @pressure.update(pressure_update_params)
      flash[:success] = "A pressão foi alterada com sucesso"
    end
      redirect_to action: :index

  end

  def destroy
    @pressure = Pressure.find(params[:id])
    if @pressure.destroy
      flash[:success] = "A pressão excluida com sucesso!"
    end

    redirect_to action: :index
  end

  # Pega somente esses parametros da request
  private
  def pressure_create_params
    params.require(:pressure).permit(:systolic,
                                    :diastolic,
                                    :data)
  end

  private
  def pressure_update_params
    params.require(:pressure).permit(:systolic,
                                    :diastolic,
                                    :data)
  end


end
