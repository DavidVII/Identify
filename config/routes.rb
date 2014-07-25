Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    confirmations: 'confirmations' }

  post '/verify-user/:id', to: 'users#verify_user', as: :verify_user
  post '/kb_auth/:id', to: 'questionnaires#authorize', as: :kb_authorization

  resources :addresses, only: [:new, :create, :edit, :update]
  resource :questionnaire, only: [:show]

  root 'pages#index'
end
