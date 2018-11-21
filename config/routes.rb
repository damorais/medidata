# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'

  resources :profiles, param: :email, email: %r{[^\/]+} do
    resources :weights
    resources :heights
    resources :pressures
    resources :contacts
    resources :allergies
    resources :medications
    resources :hdls
    resources :nonhdls
    resources :ldls
    resources :vldls
    resources :totals
    resources :reactions
    resources :glucose_measures
<<<<<<< HEAD
    resources :health_insurances
=======
>>>>>>> 57f10fd0e6fa7d57caa045e7e9db893553aa26e1
    resources :medical_appointments
  end

  root 'welcome#index'
end
