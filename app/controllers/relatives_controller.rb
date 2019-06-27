class RelativesController < ApplicationController
    layout 'internal'
  
    before_action :authenticate_user!
    before_action :block_crossprofile_access
    before_action :recover_profile
  
    def index
        @relatives = @profile.relatives
    end
   
    def new
    end
   
    def edit
        @relatives = Relative.find(params[:id])
    end

	def create
        @relative = Relative.new(relative_params)

        @relative.profile = @profile

        if @relative.save
            flash[:success] = "Relative registered sucessfully"
            redirect_to profile_relatives_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @relative = Relative.find(params[:id])
        
        if @relative.update(relative_params)
            flash[:success] = "Relative updated sucessfully"
            redirect_to profile_relatives_path(profile_email: @relative.profile.email)
        else
            render 'edit'
        end

    end
	
    def destroy
        @relative = Relative.find(params[:id])

        profile_email = @relative.profile.email

        @relative.destroy
        
        redirect_to profile_relatives_path(profile_email: profile_email)
    end
	
    private
    def relative_params
        params.require(:relative).permit(:name, :description, :)
    end
end
