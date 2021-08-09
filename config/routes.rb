Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :members, only: [:index, :show, :create] do
    member do
      get :search
    end
  end
  resources :friendships, only: [:create]
end
