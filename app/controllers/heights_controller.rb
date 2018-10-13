class HeightsController < ApplicationController

    def index
        @profile = Profile.find_by(email: params[:profile_email])
        @heights = @profile.heights
    end

    def new
        @profile = Profile.find_by(email: params[:profile_email])
    end

    def edit
        @height = Height.find(params[:id])
        @profile = @height.profile
    end

    def create
        @profile = Profile.find_by(email: params[:profile_email])
        @height = Height.new(height_params)

        @height.profile = @profile

        if @height.save
            flash[:success] = "Height registered sucessfully"
            redirect_to profile_heights_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @height = Height.find(params[:id])
        
        if @height.update(height_params)
            flash[:success] = "Height updated sucessfully"
            redirect_to profile_heights_path(profile_email: @height.profile.email)
        else
            render 'edit'
        end

    end

    def destroy
        @height = Height.find(params[:id])

        profile_email = @height.profile.email

        @height.destroy
        
        redirect_to profile_heights_path(profile_email: profile_email)
    end

    private
    def height_params
        params.require(:height).permit(:value,:date)
    end
end
