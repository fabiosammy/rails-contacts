Rails.application.routes.draw do
  resources :contacts do
    resources :phones, controller: 'contact/phones'
  end
  match '*path', action: 'handle_options_request', via: [:get, :post, :options]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
