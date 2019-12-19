Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources 'jobs', only: [:index, :show, :new, :create]
  resources 'profiles', only: [:new, :create, :show, :edit, :update]
end
