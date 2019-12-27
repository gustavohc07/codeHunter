Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources 'jobs', only: [:index, :show, :new, :create] do
    resources 'applications', only: [:new, :create]
    get 'myjobs', to: 'jobs#view_headhunter_jobs'
    get 'candidatelist', to: 'jobs#candidate_list'
  end
  resources 'applications', only: [:index, :show, :destroy] do
    resources 'proposals', only: [:index, :show, :new, :create]
    resources 'messages', only: [:new, :create]
    resources 'feedbacks', only: [:new, :create]
    post 'highlight', to: 'applications#highlight'
    post 'cancel_highlight', to: 'applications#cancel_highlight'
  end
  resources 'profiles', only: [:new, :create, :show, :edit, :update]
end
