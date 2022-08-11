Rails.application.routes.draw do
  root "boards#new"
  resources :boards
  get 'home' => 'boards#home'
end
