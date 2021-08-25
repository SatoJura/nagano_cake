Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end
  # 管理者側
  devise_for :admins, controllers: {
   ssessions:      'admins/sessions',
   passwords:      'admins/passwords'
 }

  namespace :admin do
    resources :genres, only: [:index, :create, :update, :edit]
    resources :items, except: [:destroy]
 end

  # 会員側
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  scope module: :customer do
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
