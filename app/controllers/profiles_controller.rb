class ProfilesController < ApplicationController
  
  def new
  end

  def create
    
    @profile = Profile.new(profile_params)

    if @profile.save
      flash[:success] = "O perfil foi criado com sucesso"
    end

    render 'new'

  end

  private
  def profile_params
    params.require(:profile).permit(:email, 
                                    :firstname, 
                                    :lastname, 
                                    :birthdate, 
                                    :sex, 
                                    :gender)
  end


end
