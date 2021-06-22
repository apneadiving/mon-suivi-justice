require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :convicts
  resources :users
  resources :places
  resources :appointments
  resources :slots

  get '/edit_password' => 'users#edit_password', as: 'edit_password'
  put '/update_password' => 'users#update_password'
  patch '/update_password' => 'users#update_password'
  get '/select_slot' => 'appointments#select_slot', as: 'select_slot'

  root 'static_pages#home'
end
