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
        @weight = Weight.new(weight_create_params)

        @weight.profile = @profile

        if @weight.save
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
