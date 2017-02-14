Rails.application.routes.draw do

  # resources :skill_categories
  # resources :language_users
  # resources :languages
  # resources :skills
  root                'static_page#home'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations',
  									omniauth_callbacks: "users/omniauth_callbacks", passwords: 'users/passwords', }
  devise_scope :user do
    get   'build_seller_profile'  => 'users/registrations#build_seller_profile'
  	post  'upload_picture'        => 'users/registrations#upload_picture'
    put   'update_seller_info'    => 'users/registrations#update_seller_info'
  end
  delete 'delete_language_preference' => 'language_users#destroy'
  post   'create_language_preference' => 'language_users#create'
  put    'update_language_preference' => 'language_users#update'
  get    'skills_and_categories'      => 'skill_categories#all_stuff'
  post   'user_skills'                => 'user_skills#user_skills'
  delete 'delete_user_skill'          => 'user_skills#destroy'
  put    'update_user_skill'          => 'user_skills#update'
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
