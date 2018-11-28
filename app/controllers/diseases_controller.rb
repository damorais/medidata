class DiseasesController < ApplicationController    
    layout 'internal'
  
    before_action :authenticate_user!
    before_action :block_crossprofile_access
    before_action :recover_profile
  
    def index
        @diseases = @profile.diseases
    end
   
    def new
    end
   
    def edit
        @disease = Disease.find(params[:id])
    end

	def create
        @disease = Disease.new(disease_params)

        @disease.profile = @profile

        if @disease.save
            flash[:success] = "Disease registered sucessfully"
            redirect_to profile_diseases_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @disease = Disease.find(params[:id])
        
        if @disease.update(disease_params)
            flash[:success] = "Disease updated sucessfully"
            redirect_to profile_diseases_path(profile_email: @disease.profile.email)
        else
            render 'edit'
        end

    end
	
    def destroy
        @disease = Disease.find(params[:id])

        profile_email = @disease.profile.email

        @disease.destroy
        
        redirect_to profile_diseases_path(profile_email: profile_email)
    end
	
    private
    def disease_params
        params.require(:disease).permit(:name, :cause, :description, :start, :finish)
    end
end
