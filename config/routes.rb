Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  root to: "tweets#index"
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :works, only:[:index, :new, :create, :destroy, :edit, :update]
  resources :events, only:[:index, :new, :create, :destroy, :edit, :update]
  resources :inquiries, only:[:new, :create]
end
