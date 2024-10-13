# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'questions#index'

  resources :questions, shallow: true do
    resources :answers do
      member do
        patch :set_best, to: 'answers#set_best'
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  
end
