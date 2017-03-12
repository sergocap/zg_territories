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

  scope '/:city_slug' do
    root 'organizations#index'
    resources :organizations

    namespace :my do
      resources :organizations do
        get 'managers_for_organization', on: :member
        get 'change_state', on: :member
        get 'statistics', on: :member
        get 'managing', on: :member
      end
    end
  end

  resources :organization_managers do
    get 'confirm_manager_role', on: :member
  end
  get 'categories/get_by_id'
  get 'categories/get_hierarch_list_items'
  get 'show_phone', to: 'organizations#show_phone'
end
