Rails.application.routes.draw do
  get 'isup/input'

  post 'isup/result'
  get 'isup/result'

  resources :requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'isup#input', as: 'isup'
  
end
