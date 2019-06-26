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
    resources :health_insurances
    resources :medical_appointments
	  resources :diseases		
    resources :platelets
    resources :relatives
  end

  root 'welcome#index'
end
