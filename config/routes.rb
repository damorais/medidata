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
  end

  root 'welcome#index'
end
