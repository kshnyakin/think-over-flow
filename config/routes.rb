Rails.application.routes.draw do
  devise_for :users
  resources :questions
  resources :answers
  root to: "questions#index"
end
