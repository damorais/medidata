Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, param: :email, email:  /[^\/]+/ do
    resources :pressures 
  end
                        # only: [:index, :new, :create, :edit, :update]
  root 'welcome#index'

end
