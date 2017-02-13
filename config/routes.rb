Rails.application.routes.draw do
  root 'organizations#index'
  namespace :manage do
    namespace :metadata do
      resources :categories
    end
  end
end
