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
    resources :platelets
  end

  root 'welcome#index'
end
