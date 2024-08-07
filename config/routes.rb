# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'question#index'

  resources :questions, shallow: true do
    resources :answers, only: [:show, :new, :edit, :create]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

end
