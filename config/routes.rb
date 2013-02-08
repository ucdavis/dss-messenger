DssMessenger::Application.routes.draw do

  resources :classifications


  resources :modifiers


  resources :recipients


  resources :messages

  root :to => 'messages#index'

end
