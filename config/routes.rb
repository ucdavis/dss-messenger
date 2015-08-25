DssMessenger::Application.routes.draw do

  # This action must come before 'resources :messages'
  get "/messages/open" => 'messages#open'

  resources :message_receipts
  resources :recipients

  resources :messages do
    get "duplicate"
    get "archive"
    get "reactivate"
  end

  namespace :preferences do
    resources :publishers
    resources :impacted_services
    resources :classifications
    resources :modifiers
    resources :settings
  end

  get "/logout" => 'application#logout'

  get "/status" => 'application#status'
  get "/delayed_job_status" => 'delayed_job_status#index'

  root :to => 'messages#index'
end
