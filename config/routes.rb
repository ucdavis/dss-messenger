DssMessenger::Application.routes.draw do

  resources :modifiers


  resources :recipients


  resources :messages

  root :to => 'messages#index'

end
