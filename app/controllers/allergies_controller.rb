class AllergiesController < ApplicationController

    def index
        @profile = Profile.find_by(email: params[:profile_email])
        @allergies = @profile.allergies
    end
   
    def new
        @profile = Profile.find_by(email: params[:profile_email])
    end
   
    def edit
        @allergy = Allergy.find(params[:id])
        @profile = @allergy.profile
    end

	def create
        @allergy = Allergy.new(allergy_params)
        @profile = Profile.find_by(email: params[:profile_email])		

        @allergy.profile = @profile

        if @allergy.save
            flash[:success] = "Allergy registered sucessfully"
            redirect_to profile_allergies_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @allergy = Allergy.find(params[:id])
        
        if @allergy.update(allergy_params)
            flash[:success] = "Allergy updated sucessfully"
            redirect_to profile_allergies_path(profile_email: @allergy.profile.email)
        else
            render 'edit'
        end

    end
	
    def destroy
        @allergy = Allergy.find(params[:id])

        profile_email = @allergy.profile.email

        @allergy.destroy
        
        redirect_to profile_allergies_path(profile_email: profile_email)
    end
	
    private
    def allergy_params
        params.require(:allergy).permit(:name,:description)
    end
end
