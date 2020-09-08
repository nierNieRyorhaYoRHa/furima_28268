Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
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
