DssMessenger::Application.routes.draw do

  resources :message_receipts


  resources :settings


  resources :impacted_services


  resources :classifications


  resources :modifiers


  resources :recipients

  resources :publishers

  resources :delayed_job_status

  get "/messages/open" => 'messages#open'
  resources :messages
  
  root :to => 'messages#index'
  get "/logout" => 'application#logout'
end
