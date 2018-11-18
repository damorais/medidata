# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'

<<<<<<< HEAD
  resources :profiles, param: :email, email: %r{[^\/]+} do
=======
  resources :profiles, param: :email, email:  /[^\/]+/ do
>>>>>>> dddc9b5ad46f8865c828df9a860837eefefd8205
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
<<<<<<< HEAD
    resources :reactions
    resources :glucose_measures
=======
    resources :platelets
>>>>>>> dddc9b5ad46f8865c828df9a860837eefefd8205
  end

  root 'welcome#index'
end
