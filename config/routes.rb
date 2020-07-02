Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  post '/callback' => 'linebot#callback'
  
  get '/search', to: 'users#search'
  get '/q_a', to: 'users#q_a'
  get '/course', to: 'users#course'
  

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
   patch 'users/:user_id/attendances/:id/todays_test', to: 'attendances#todays_test', as: :todays_test_attendances
   
   patch 'users/:user_id/inquiries/:id/update_q_answer', to: 'inquiries#update_q_answer', as: :update_q_answer_inquiries
   #get 'users/:user_id/inquiries/:id/edit_answer', to: 'inquiries#edit_answer', as: :edit_answer_inquiries
   
   post   '/course', to: 'courses#create'
   delete '/course/:id', to: 'courses#destroy'
   
   delete '/edit_question/:id', to: 'users#destroy_question'
   

  resources :users do
      get :search_students, on: :collection
      get :edit_course, on: :collection
      
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
      
      get 'edit_question'
      
      get 'edit_note'
      patch 'update_note'
      
    #  get 'edit_answer'
    #  post 'create_answer'
      get 'inquiries/edit_answer'
      patch 'inquiries/update_answer'
      
     # patch 'inquiries/update_q_answer'
      
      get 'inquiries/q_a'
      
     # patch 'attendances/todays_test'
    end
    resources :attendances, only: :update # この行を追加します。
    resources :inquiries,   only: [:question, :create, :destroy]
  end
  
end