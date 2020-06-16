Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get '/search', to: 'users#search'
  get '/q_a', to: 'users#q_a'
  

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
   patch 'users/:user_id/attendances/:id/todays_test', to: 'attendances#todays_test', as: :todays_test_attendances
   
   #get 'users/:id/inquiries/q_a', to: 'inquiries#q_a', as: :q_a_inquiries

  resources :users do
      get :search_students, on: :collection
      
    member do
      get 'basic_information'
      patch 'update_basic_information'
      
      get 'edit_basic_info'
      patch 'update_basic_info'
      
      get 'line_chat'
      get 'test_results'
      
      get 'attendances/edit_inquiry'
      post 'attendances/create_inquiry'
      
      get 'inquiries/question'
      post 'inquiries/create'
      
      get 'edit_note'
      patch 'update_note'
      
      
      
     # get 'inquiries/q_a'
      
     # patch 'attendances/todays_test'
    end
    resources :attendances, only: :update # この行を追加します。
    resources :inquiries,   only: [:question, :create, :destroy]
  end
  
end