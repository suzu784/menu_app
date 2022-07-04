Rails.application.routes.draw do

  # customer側ルーティング
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
     root 'homes#top'
     get 'about' => 'homes#about'
     resources :posts, only: [:index, :show, :edit, :update, :destroy] do
       resource :favorites, only: [:create, :destroy]
       resources :post_comments, only: [:create, :destroy]
     end
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
        get :followings, to: 'customers#followings', as: 'followings'
        get :followers, to: 'customers#followers', as: 'followers'
      end
     resources :categories, only: [:index]
     resources :recipes, only: [:index, :show, :edit, :update]
   end

  # admin側ルーティング
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
     root 'orders#index'
     resources :customers, only: [:index, :edit, :update, :show]
     resources :posts, only: [:index, :show, :destroy]
     get 'confirm', to: 'posts#confirm'
  end
end