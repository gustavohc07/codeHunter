Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources 'jobs', only: [:index, :show, :new, :create] do
    resources 'applications', only: [:new, :create]
    get 'myjobs', to: 'jobs#view_headhunter_jobs'
    get 'candidatelist', to: 'jobs#candidate_list'
    post 'close_application', to: 'jobs#close_application'
  end
  resources 'applications', only: [:index, :show, :destroy] do
    resources 'proposals', only: [:show, :new, :create]
    resources 'messages', only: [:new, :create]
    resources 'feedbacks', only: [:new, :create]
    post 'highlight', to: 'applications#highlight'
    post 'cancel_highlight', to: 'applications#cancel_highlight'
  end
  resources 'proposals', only: [:index] do
    get 'accept', to: 'proposals#new_accept'
    post 'accept', to: 'proposals#accept'
    get 'decline', to: 'proposals#new_decline'
    post 'decline', to: 'proposals#decline'
  end
  resources 'profiles', only: [:new, :create, :show, :edit, :update]

  namespace 'api' do
    namespace 'v1' do
      resources :jobs, only: %i[index show create update destroy]
    end
  end
end
