# frozen_string_literal: true

Rails.application.routes.draw do

  resources :pokemon do
    collection do
      get :search
    end
  end
end
