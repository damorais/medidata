class MedicalAppointmentsController < ApplicationController
  layout 'internal'

  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @medical_appointments = @profile.medical_appointments
  end

  def new
  end

  def edit
    @medical_appointment = MedicalAppointment.find(params[:id])
  end

  def create
    @medical_appointment = MedicalAppointment.new(medical_appointment_params)

    @medical_appointment.profile = @profile

    if @medical_appointment.save
      flash[:success] = 'Medical Appointment registered sucessfully'
      redirect_to profile_medical_appointments_path(profile_email: @profile.email)
    else
      render 'new'
    end
  end

  def update
    @medical_appointment = MedicalAppointment.find(params[:id])

    if @medical_appointment.update(medical_appointment_params)
      flash[:success] = 'Medical Appointment updated sucessfully'
      redirect_to profile_medical_appointments_path(profile_email: @medical_appointment.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @medical_appointment = MedicalAppointment.find(params[:id])

    profile_email = @medical_appointment.profile.email

    if @medical_appointment.destroy
      flash[:success] = 'Medical Appointment successfully excluded'
    end
      redirect_to profile_medical_appointments_path(profile_email: profile_email)
  end

  private
  def medical_appointment_params
    params.require(:medical_appointment).permit(:specialty, :address, :professional, :type_appointment, :note)
  end
end
