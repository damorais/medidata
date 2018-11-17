class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :block_crossprofile_access, except: [:index, :new, :create]
  before_action :recover_profile, except: [:index, :new, :create]

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new(email: current_user.email)
  end

  def show; end

  def edit
    @profile = Profile.find_by(email: params[:email])
  end

  def create
    @profile = Profile.new(profile_create_params)
    @profile.email = current_user.email
    @profile.user = current_user

    if @profile.save
      flash[:success] = 'O perfil foi criado com sucesso'
      redirect_to profile_path(email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @profile = Profile.find_by(email: params[:email])

    if @profile.update(profile_update_params)
      flash[:success] = 'O perfil foi modificado com sucesso'
    end

    render 'edit'
  end

  private

  def profile_create_params
    params.require(:profile).permit(:firstname,
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
