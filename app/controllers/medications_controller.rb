class MedicationsController < ApplicationController

def index
    @profile = Profile.find_by(email: params[:profile_email])
    @medications = @profile.medications
end

def new
    @profile = Profile.find_by(email: params[:profile_email])
end

def edit
    @medication = Medication.find(params[:id])
    @profile = @medication.profile
end

def create

    @profile = Profile.find_by(email: params[:profile_email])
    @medication = Medication.new(medication_params)

    @medication.profile = @profile

    if @medication.save
        flash[:success] = "Medication registered sucessfully"
        redirect_to profile_medications_path(profile_email: @profile.email)
    else
        render 'new'
    end
end

def update
    @medication = Medication.find(params[:id])

    if @medication.update(medication_params)
        flash[:success] = "Medication updated sucessfully"
        redirect_to profile_medications_path(profile_email: @medication.profile.email)
    else
        render 'edit'
    end

end

def destroy
    @medication = Medication.find(params[:id])

    profile_email = @medication.profile.email

    @medication.destroy

    redirect_to profile_medications_path(profile_email: profile_email)
end

private
def medication_params
    params.require(:medication).permit(:name,:categorize,:start,:finish,:dosage,:infadd)
end
end
