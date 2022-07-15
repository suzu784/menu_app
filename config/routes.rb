Rails.application.routes.draw do

  #ゲストログインルーティング
  devise_scope :customer do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # customer側ルーティング
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
     root 'homes#top'
     get :about, to: 'homes#about'
     get :timeline, to: 'homes#timeline', as: 'timeline'
     resources :events
     resources :posts do
       collection do
         get :popular
       end
       resource :favorites, only: [:create, :destroy]
       resources :post_comments, only: [:create, :destroy]
       resources :recipes, except: [:destroy] do
       collection do
          get :confirm
        end
      end
     end
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
        get :followings, to: 'customers#followings', as: 'followings'
        get :followers, to: 'customers#followers', as: 'followers'
      end
     resources :categories, only: [:index]
     resources :chats, only: [:show, :create]
     get :youtube, to: 'youtube#recommendation', as: 'youtube'
     resources :notifications, only: [:index] do
       collection do
        delete :destroy_all
      end
     end
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