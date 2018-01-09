Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount ActionCable.server => "/cable"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :ideas do
        collection do
          post 'search'
          get 'total_ideas'
        end
      end
      resources :conversations do
        collection do
          get 'total_conversations'
        end
      end
      resources :messages
    end
  end

end
