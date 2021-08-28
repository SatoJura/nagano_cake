Rails.application.routes.draw do
  # 管理者側
  devise_for :admins, controllers: {
   ssessions:      'admins/sessions',
   passwords:      'admins/passwords'
 }

  namespace :admin do
    resources :genres, only: [:index, :create, :update, :edit]
    resources :items, except: [:destroy]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index,:show,:edit,:update]
 end

  # 会員側
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

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
    
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
