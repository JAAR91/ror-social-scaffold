Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:index, :create, :destroy, :update]
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get '/users/:user_id/friend_request', to: 'friendships#friend_request', as: 'invitations'
  patch '/friendship/:id', to: 'friendships#friendaccepted', as: 'inviteaccepted'
  delete '/friendship/:id', to: 'friendships#frienddecline', as: 'invitedecline'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
