Rails.application.routes.draw do
  # resources :skills
  root                'static_page#home'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations',
  									omniauth_callbacks: "users/omniauth_callbacks", passwords: 'users/passwords', }

	get   'build_profile'         => 'users#build_profile'
	post  'upload_picture'          => 'users#upload_picture'  						
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
