Rails.application.routes.draw do
  get 'static_pages/index'
  get 'twitter/index'
  get 'github/index'
  get 'contacts/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root :to=> "static_pages#index"
resources :github, only: [:index]
resources :twitter, only: [:index]
resources :contacts, only: [:index,:create]
end
