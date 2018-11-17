# frozen_string_literal: true

class GlucoseMeasuresController < ApplicationController
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @glucose_measures = @profile.glucose_measures
  end

  def new; end

  def edit
    @glucose_measure = GlucoseMeasure.find_by(id: params[:id])
  end

  def create
    @glucose_measure = GlucoseMeasure.new(glucose_measure_params)
    @glucose_measure.profile = @profile
    if @glucose_measure.save
      flash[:success] = 'Glucose measure registered successfully'
      @glucose_measures = @profile.glucose_measures
      redirect_to profile_glucose_measures_path(profile_email: @profile.email)
    else
      render 'new'
    end
end

  def update
    @glucose_measure = GlucoseMeasure.find_by(id: params[:id])

    if @glucose_measure.update(glucose_measure_params)
      flash[:success] = 'Glucose measure was changed successfully'
      redirect_to profile_glucose_measures_path(profile_email: @glucose_measure.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @glucose_measure = GlucoseMeasure.find(params[:id])

    if @glucose_measure.destroy
      flash[:success] = 'Glucose measure successfully excluded'
    end
    redirect_to action: :index
  end

  private

  def glucose_measure_params
    params.require(:glucose_measure).permit(:value,
                                            :fasting,
                                            :date)
  end
end
