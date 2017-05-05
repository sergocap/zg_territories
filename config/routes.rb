Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'organizations#welcome'
  namespace :manage do
    root 'organizations#index'
    resources :organizations do
      get 'logotype', on: :member
      get 'gallery', on: :member
      get 'description_field', on: :member
      get 'statistics', on: :member
      get 'change_state', on: :member
    end

    resources :service_packs, except: :show

    namespace :metadata do
      root 'categories#index'
      resources :categories do
        put  'update_row_order_property', on: :collection
        get 'parent_params', on: :member
        resources :properties
      end
    end

    resources :my_resource_requests do
      get 'allow', on: :member
      get 'disallow', on: :member
    end

    resources :meta_fields
  end

  scope '/:city_slug' do
    root 'organizations#index'
    resources :organizations, only: [:welcome, :index, :show] do
      resources :my_resource_requests, only: [:new, :create]
    end

    namespace :my do
      resources :organizations do
        get 'managers_for_organization', on: :member
        get 'change_state', on: :member
        get 'logotype', on: :member
        get 'gallery', on: :member
        get 'description_field', on: :member
        get 'statistics', on: :member
        get 'service_packs', on: :member
        get 'managing', on: :member
      end
    end
  end

  get 'payments/create', to: 'payments#create'

  resources :organization_managers do
    get 'confirm_manager_role', on: :member
    get 'transfer_main_role', on: :member
  end

  get 'organizations/show_phone'
  get 'organizations/service_packs'
  get 'categories/get_by_id'
  get 'categories/get_hierarch_list_items'

  scope 'robokassa' do
    post 'paid'    => 'robokassa#paid',    :as => :robokassa_paid
    post 'success' => 'robokassa#success', :as => :robokassa_success
    post 'fail'    => 'robokassa#fail',    :as => :robokassa_fail
  end
end
