Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  get 'cards/new'
  root to: 'items#index'
  resources :users do
    resources :cards
  end
  resources :items do
    resources :purchases, only:[:index, :create]
    resources :comments, only: :create
    collection do
      get 'search'
      get 'item_search'
      get 'tag_search'
      get 'brand'
      get 'category'
    end
  end

end
