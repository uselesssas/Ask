Rails.application.routes.draw do
  resources :questions

  root 'welcome#index'
end
