DssMessenger::Application.routes.draw do

  resources :impacted_services


  resources :classifications


  resources :modifiers


  resources :recipients

  resources :messages
  
  root :to => 'messages#index'
  get "/logout" => 'application#logout'

end
