DssMessenger::Application.routes.draw do

  resources :recipients


  resources :messages

  root :to => 'messages#index'

end
