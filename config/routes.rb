Rails.application.routes.draw do
  # 管理者側
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:      'admins/passwords'
 }

  namespace :admin do
    get ''=> 'homes#top'
    resources :genres, only: [:index, :create, :update, :edit]
    resources :items, except: [:destroy]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :order_details, only: [:update]
 end

  # 会員側
  devise_for :customers, skip: [:registrations, :passwords],
                         controllers: {
  sessions:      'customers/sessions',
  registrations: 'customers/registrations'
 }
  devise_scope :customer do
    get 'customers/sign_up' => 'customers/registrations#new', as: :new_customer_registration
    post 'customers' => 'customers/registrations#create', as: :customer_registration
  end

  scope module: :public do
    resource :customers, only: [:edit, :update]
    get "customers/my_page" => "customers#show"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/change" => "customers#change"

    root to: 'homes#top'
    get 'about' => "homes#about"

    post 'orders/confirm'
    get 'orders/thanks'
    resources :orders, only: [:new, :create, :index, :show]

    resources :items, only: [:index, :show]

    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
