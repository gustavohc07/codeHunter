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
    post 'highlight', to: 'applications#highlight'
    post 'cancel_highlight', to: 'applications#cancel_highlight'
    resources 'messages', only: [:new, :create]
  end
  resources 'profiles', only: [:new, :create, :show, :edit, :update]
end
