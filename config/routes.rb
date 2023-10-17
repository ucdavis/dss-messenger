Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # This action must come before 'resources :messages'
  get '/messages/open' => 'messages#open'

  resources :message_receipts
  resources :recipients

  resources :messages do
    get 'duplicate'
    get 'archive'
    get 'reactivate'
  end

  namespace :preferences do
    resources :publishers
    resources :impacted_services
    resources :classifications
    resources :modifiers
    resources :settings
  end

  get '/job_status' => 'application#job_status'
  get '/clear_queue' => 'application#clear_queue'

  get '/logout' => 'application#logout'

  get '/status' => 'application#status'
  get '/delayed_job_status' => 'delayed_job_status#index'

  root to: 'messages#index'

  # Leave this route at the end to capture 404s
  match '*path' => 'application#error_404', via: :all
  # The above rule doesn't match the root, so add it
  match '/' => 'application#error_404', via: :all
end
