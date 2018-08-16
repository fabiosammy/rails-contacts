Rails.application.routes.draw do
  resources :contacts do
    resources :phones, controller: 'contact/phones'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
