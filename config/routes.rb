DssMessenger::Application.routes.draw do

  resources :messenger_events


  resources :impacted_services


  resources :classifications


  resources :modifiers


  resources :recipients


  resources :messages

  root :to => 'messages#index'

end
