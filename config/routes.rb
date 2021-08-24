Rails.application.routes.draw do
  # 管理者側
  devise_for :admins, controllers: {
   ssessions:      'admins/sessions',
   passwords:      'admins/passwords'
 }

  # 会員側
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
