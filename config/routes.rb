Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    confirmations: 'confirmations' }

  post '/kb_auth/:id', to: 'questionnaires#score_question_set', as: :kb_authorization

  get '/success', to: 'pages#success', as: :success_page

  resources :addresses, only: [:new, :create, :edit, :update]
  resource :questionnaire, only: [:show]

  root 'pages#index'
end
