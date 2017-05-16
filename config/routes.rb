Rails.application.routes.draw do
#  get 'users/index'
  resources :users
  get "users/all"
  scope :format => true, :constraints => { :format => 'json' } do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
  end
end
