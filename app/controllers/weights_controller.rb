class WeightsController < ApplicationController

    def index
        @profile = Profile.find_by(email: params[:profile_email])
        @weights = @profile.weights
    end

    def new
        @profile = Profile.find_by(email: params[:profile_email])
    end

    def create

        @profile = Profile.find_by(email: params[:profile_email])

        if @profile.weights.create(weight_create_params)
            flash[:success] = "Weight registered sucessfully"
            redirect_to profile_weights_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    private
    def weight_create_params
        params.require(:weight).permit(:value,:date)
    end
end
