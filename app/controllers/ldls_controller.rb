class LdlsController < ApplicationController

    before_action :recover_profile

    def index
        @ldls = @profile.ldls
    end

    def new
    end

    def edit
        @ldl = Ldl.find(params[:id])
    end

    def create
        @ldl = Ldl.new(ldl_params)

        @ldl.profile = @profile

        if @ldl.save
            flash[:success] = "LDL Cholesterol registered sucessfully"
            redirect_to profile_ldls_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @ldl = Ldl.find(params[:id])
        
        if @ldl.update(ldl_params)
            flash[:success] = "LDL Cholesterol updated sucessfully"
            redirect_to profile_ldls_path(profile_email: @ldl.profile.email)
        else
            render 'edit'
        end

    end

    def destroy
        @ldl = Ldl.find(params[:id])

        profile_email = @ldl.profile.email

        @ldl.destroy
        
        redirect_to profile_ldls_path(profile_email: profile_email)
    end

    private
    def ldl_params
        params.require(:ldl).permit(:value,:date)
    end
end
