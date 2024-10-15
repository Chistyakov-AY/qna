# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'questions#index'

  resources :questions, shallow: true do
    resources :answers
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
