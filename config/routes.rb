Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # api/v1/inbox

  namespace :api do
    namespace :v1 do
      resources :inboxes
      resources :chats
      get 'chats/sender/:sender_id', to: 'chats#show_by_sender', as: 'api_v1_chats_sender'
    end
  end
end
