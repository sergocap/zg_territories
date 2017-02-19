Rails.application.routes.draw do

  root 'organizations#welcome'
  scope '/:city_slug' do
    get '/', to: 'organizations#index'
    resources :organizations
    namespace :manage do
      namespace :metadata do
        resources :categories do
          get 'parent_params', on: :member
          resources :properties
        end
      end
    end

    namespace :my do
      resources :organizations
    end
  end
end
