Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    confirmations: 'confirmations' }

  get 'user/:id', to: 'verifications#create', as: :user
  get '/unverified', to: 'pages#unverified'

  root 'pages#index'
end
