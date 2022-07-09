Rails.application.routes.draw do

  # customer側ルーティング
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
     root 'homes#top'
     get :about, to: 'homes#about'
     get :events, to: 'events#index'
     resources :posts, only: [:new, :index, :show, :edit, :update, :destroy] do
       resource :favorites, only: [:create, :destroy]
       resources :post_comments, only: [:create, :destroy]
       resources :recipes, except: [:destroy]
     end
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get :favorites, to: 'customers#favorites'
      end
      resource :relationships, only: [:create, :destroy]
        get :followings, to: 'customers#followings', as: 'followings'
        get :followers, to: 'customers#followers', as: 'followers'
      end
     resources :categories, only: [:index]
     resources :chats, only: [:show, :create]
   end

  # admin側ルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
     root 'customers#index'
     resources :customers, only: [:index, :edit, :update, :show] do
      patch :withdraw, to: 'customers#withdraw'
      get :confirm, to: 'customers#confirm'
    end
     resources :posts, only: [:index, :show, :destroy]
  end
end