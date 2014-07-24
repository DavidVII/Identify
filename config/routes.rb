Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    confirmations: 'confirmations' }

  post '/verify-user/:id', to: 'users#verify_user', as: :verify_user
  get '/unverified', to: 'pages#unverified', as: :unverified

  root 'pages#index'
end
