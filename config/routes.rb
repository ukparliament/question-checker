Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  mount LibraryDesign::Engine => "/library_design"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'home#index', as: :root
  
  get 'questions' => 'question#index', as: :question_list
  
  get 'houses' => 'house#index', as: :house_list
  get 'houses/:house' => 'house#show', as: :house_show
  
  get 'houses/:house/questions' => 'house_question#index', as: :house_question_list
  
  get 'houses/:house/members' => 'house_member#index', as: :house_member_list
  
  get 'houses/:house/answering-bodies' => 'house_answering_body#index', as: :house_answering_body_list
  get 'houses/:house/answering-bodies/:answering_body' => 'house_answering_body#show', as: :house_answering_body_show
  
  get 'answering-bodies' => 'answering_body#index', as: :answering_body_list
  get 'answering-bodies/:answering_body' => 'answering_body#show', as: :answering_body_show
  
  get 'answering-bodies/:answering_body/questions' => 'answering_body_question#index', as: :answering_body_question_list
  
  get 'members' => 'member#index', as: :member_list
  get 'members/:member' => 'member#show', as: :member_show
  
  get 'members/:member/questions' => 'member_question#index', as: :member_question_list
  
  get 'meta' => 'meta#index', as: :meta_list
  get 'meta/cookies' => 'meta#cookies', as: :meta_cookies
end
