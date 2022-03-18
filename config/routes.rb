Rails.application.routes.draw do
  devise_for :users
  post '/users/update_points', to:'points#update_points'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
