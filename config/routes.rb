# frozen_string_literal: true

Rails.application.routes.draw do
  resources :robots, only: [] do
    member do
      post :control, to: 'robot_control#control'
    end
  end
end
