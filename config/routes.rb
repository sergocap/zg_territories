Rails.application.routes.draw do

  root 'organizations#welcome'
  namespace :manage do
    root 'organizations#index'
    resources :organizations do
      get 'change_state', on: :member
    end
    namespace :metadata do
      root 'categories#index'
      resources :categories do
        get 'parent_params', on: :member
        resources :properties
      end
    end
  end
  get 'categories/get_by_id'
  get 'categories/get_hierarch_list_items'

  scope '/:city_slug' do
    root 'organizations#index'
    resources :organizations
    namespace :my do
      resources :organizations do
        get 'change_state', on: :member
      end
    end
  end

end
