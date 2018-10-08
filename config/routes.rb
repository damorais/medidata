Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, param: :email, email:  /[^\/]+/ do
                        # only: [:index, :new, :create, :edit, :update]
	resources :contacts 
  
  end
  root 'welcome#index'

end
