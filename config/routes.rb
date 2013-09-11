FootballPredictions::Application.routes.draw do

  devise_for :users
  resources :predictions

  root 'predictions#new'
end
