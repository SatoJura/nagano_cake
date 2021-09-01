Rails.application.routes.draw do

  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
    get 'addresses/create'
    get 'addresses/update'
    get 'addresses/destroy'
  end
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
 end

  # 会員側
  devise_for :customers

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

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
