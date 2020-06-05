Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/search', to: 'users#search'
  get '/q_a', to: 'users#q_a'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'basic_information'
      
      get 'edit_basic_info'
      patch 'update_basic_info'
      
      get 'line_chat'
      get 'test_results'
      get 'question'
    end
    resources :attendances, only: :update # この行を追加します。
  end
end