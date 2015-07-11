Rails.application.routes.draw do
  resources :categories do
    resources :products do
      resources :reviews
    end
  end

  devise_for :users, :controllers => { :registrations => 'user_registrations' }
  as :user do
    post '/login' => 'devise/sessions#new', as: :session_path
  end

  root 'categories#index'
end
