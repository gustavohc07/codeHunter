Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources 'jobs', only: [:index, :show, :new, :create] do
    resources 'applications', only: [:new, :create]
    get 'myjobs', to: 'jobs#view_headhunter_jobs'
  end
  resources 'applications', only: [:index, :show, :destroy]
  resources 'profiles', only: [:new, :create, :show, :edit, :update]
end
