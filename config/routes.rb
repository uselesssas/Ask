Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  resources :questions, only: %i[index show new create edit update destroy] do
    resources :answers, expect: %i[index show new]
  end

  root 'welcome#index'
end
