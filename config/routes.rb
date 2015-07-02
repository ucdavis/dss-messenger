DssMessenger::Application.routes.draw do

  resources :message_receipts


  resources :settings


  resources :impacted_services


  resources :classifications


  resources :modifiers


  resources :recipients

  resources :publishers

  get "/messages/open" => 'messages#open'
  resources :messages
  
  root :to => 'messages#index'

  get "/logout" => 'application#logout'
  get "/status" => 'application#status'
  get "/delayed_job_status" => 'delayed_job_status#index'
end
