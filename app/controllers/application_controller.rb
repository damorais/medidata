class ApplicationController < ActionController::Base

    def recover_profile
        if params[:profile_email]
            @profile = Profile.find_by(email: params[:profile_email])
        end

        if not @profile
            raise ActionController::RoutingError.new('Not Found')
        end
    end
end
