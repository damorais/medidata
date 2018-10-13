Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :profiles, param: :email, email:  /[^\/]+/ do
    resources :weights
    resources :heights
  end

  root 'welcome#index'

end
