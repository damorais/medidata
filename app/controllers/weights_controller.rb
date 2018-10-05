class WeightsController < ApplicationController

    def index
        @profile = Profile.find_by(email: params[:profile_email])
        @weights = @profile.weights
    end
end
