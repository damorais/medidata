Rails.application.routes.draw do
  get 'welcome/index'
<<<<<<< HEAD
  
  resources :profiles, param: :email, email:  /[^\/]+/ do
    resources :weights
    resources :heights
  end

=======
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, param: :email, email:  /[^\/]+/ do
    resources :pressures 
  end
                        # only: [:index, :new, :create, :edit, :update]
>>>>>>> Pressao Sanguinea - new, edit, delete
  root 'welcome#index'

end
