Rails.application.routes.draw do
  root 'organizations#index'
  namespace :manage do
    namespace :metadata do
      resources :categories do
        resources :properties
      end
    end
  end
end
