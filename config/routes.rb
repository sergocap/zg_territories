Rails.application.routes.draw do

  root 'organizations#welcome'
  namespace :manage do
    namespace :metadata do
      resources :categories do
        get 'parent_params', on: :member
        resources :properties
      end
    end
  end
  get 'categories/get_by_id'
  get 'categories/get_hierarch_list_items'

  scope '/:city_slug' do
    get '/', to: 'organizations#index'
    resources :organizations
    namespace :my do
      resources :organizations
    end
  end

end
