# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources 'jobs', only: %i[index show new create] do
    resources 'applications', only: %i[new create]
    get 'myjobs', to: 'jobs#view_headhunter_jobs'
    get 'candidatelist', to: 'jobs#candidate_list'
    post 'close_application', to: 'jobs#close_application'
  end
  resources 'applications', only: %i[index show destroy] do
    resources 'proposals', only: %i[show new create]
    resources 'messages', only: %i[new create]
    resources 'feedbacks', only: %i[new create]
    post 'highlight', to: 'applications#highlight'
    post 'cancel_highlight', to: 'applications#cancel_highlight'
  end
  resources 'proposals', only: [:index] do
    get 'accept', to: 'proposals#new_accept'
    post 'accept', to: 'proposals#accept'
    get 'decline', to: 'proposals#new_decline'
    post 'decline', to: 'proposals#decline'
  end
  resources 'profiles', only: %i[new create show edit update]

  namespace 'api' do
    namespace 'v1' do
      resources :jobs, only: %i[index show create update destroy]
    end
  end
end
