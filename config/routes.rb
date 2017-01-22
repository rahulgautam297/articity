Rails.application.routes.draw do
  # resources :skills
  root                'static_page#home'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do
  	get    'user_profile'          => 'users/sessions#show'
 	patch  'profile_picture'	   => 'users/sessions#picture'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
