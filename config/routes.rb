Rails.application.routes.draw do
  use_doorkeeper do
	  skip_controllers :authorizations, :applications,
	    :authorized_applications
	end
  mount ActionCable.server => '/cable'
  # devise_for :users
  devise_for :users, controllers: {
           :sessions => "users/sessions",
           :registrations => "users/registrations" }


  resources :chatrooms do
    resource :chatroom_users
    resources :messages
    collection do
      get 'joins_channel'
    end
  end

  resources :direct_messages
  resources :users, only: [:index]

  root to: "chatrooms#index"
end
