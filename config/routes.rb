Rails.application.routes.draw do
  devise_for :users
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :splits, only: %i[index show new create destroy] do
    resources :bills, only: %i[index show new create destroy] do
      collection do
        get :receipt
        post :upload
      end
    end
  end
end

# def tabulate
#   @split = Split.find_by(invite_code: params[:id])
# end

# splits/9382d98d392j3d/tabulate
