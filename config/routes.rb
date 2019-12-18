Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources 'jobs', only: [:index, :show, :new, :create]
end
