Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # переработать роутинг и структуры
  resources :questions do
    resources :answers, shallow: true
  end
  root to: 'questions#index'
end
