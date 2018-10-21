Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :profiles, param: :email, email:  /[^\/]+/ do
    
    resources :weights do
      collection do
        get 'latest'
      end
    end

    resources :heights
    resources :contacts
    resources :allergies    

  end

  root 'welcome#index'

end
