DssMessenger::Application.routes.draw do

  resources :settings


  resources :impacted_services


  resources :classifications


  resources :modifiers


  resources :recipients

  get "/messages/open" => 'messages#open'
  get "/messages/track/:id" => 'messages#track'
  resources :messages
  
  root :to => 'messages#index'
  get "/logout" => 'application#logout'
end
