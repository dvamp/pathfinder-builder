Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dragon_builder
  root :to => "dragon_builder#index"
end
