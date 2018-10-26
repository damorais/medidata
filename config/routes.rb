Rails.application.routes.draw do
  get 'welcome/index'

  resources :profiles, param: :email, email:  /[^\/]+/ do
    resources :weights
    resources :heights
    resources :pressures
    resources :contacts
    resources :allergies
    resources :medications
    resources :glucose_measures 
  end

  root 'welcome#index'

end
