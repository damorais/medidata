class TotalsController < ApplicationController

    before_action :recover_profile

    def index
        @totals = @profile.totals
    end

    def new
    end

    def edit
        @total = Total.find(params[:id])
    end

    def create
        @total = Total.new(total_params)

        @total.profile = @profile

        if @total.save
            flash[:success] = "Total Cholesterol registered sucessfully"
            redirect_to profile_totals_path(profile_email: @profile.email)
        else
            render 'new'
        end
    end

    def update
        @total = Total.find(params[:id])
        
        if @total.update(total_params)
            flash[:success] = "Total Cholesterol updated sucessfully"
            redirect_to profile_totals_path(profile_email: @total.profile.email)
        else
            render 'edit'
        end

    end

    def destroy
        @total = Total.find(params[:id])

        profile_email = @total.profile.email

        @total.destroy
        
        redirect_to profile_totals_path(profile_email: profile_email)
    end

    private
    def total_params
        params.require(:total).permit(:value,:date)
    end
end
