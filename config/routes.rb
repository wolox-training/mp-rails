Rails::application.routes.draw do
  api_version(:module => "Api::V1", :path => {:value => "api/v1"}) do
    resources :books, only: [:index, :show]
    resources :rents, only: [:index, :show, :create]
    mount_devise_token_auth_for 'User', at: 'auth'
  end
end
