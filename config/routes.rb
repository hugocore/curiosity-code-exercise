# frozen_string_literal: true

Rails.application.routes.draw do
  resources :robots, only: [] do
    member do
      post :move, to: 'navigation#move'
    end
  end
end
