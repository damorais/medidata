# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    profile_path(email: resource.email)
  end

  def recover_profile
    email = params[:profile_email] || params[:email]

    @profile = Profile.find_by(email: email) if email

    redirect_to new_profile_path unless @profile
  end

  def block_crossprofile_access
    authorized = current_user.email == (params[:profile_email] || params[:email])

    render file: 'public/401.html', layout: false, status: :unauthorized unless authorized
  end
end
