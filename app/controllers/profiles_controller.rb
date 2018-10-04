class ProfilesController < ApplicationController
 
  def index
    @profiles = Profile.all
  end

  def new
  end

  def show
  end

  def edit
    @profile = Profile.find_by(email: params[:email]) 
  end

  def create
    
    @profile = Profile.new(profile_create_params)

    if @profile.save
      flash[:success] = "O perfil foi criado com sucesso"
    end

    render 'new'

  end

  def update
    @profile = Profile.find_by(email: params[:email])

    if @profile.update(profile_update_params)
      flash[:success] = "O perfil foi modificado com sucesso"
    end

    render "edit"
                               
  end

  private
  def profile_create_params
    params.require(:profile).permit(:email, 
                                    :firstname, 
                                    :lastname, 
                                    :birthdate, 
                                    :sex, 
                                    :gender)
  end

  def profile_update_params
    params.require(:profile).permit(:birthdate,
                                    :sex,
                                    :gender)
  end

end
