Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Cfa::Styleguide::Engine => "/cfa"

  root "pages#index"
  get "/download", to: "pages#download"
  get "/upload", to: "clients#new"

  resources :clients do
    # get "/download_pdf", to: "clients#pdf"
  end
  resources :feedbacks, only: [:new, :create]





  get "/minimal", to: "pages#minimal"
  get "/full", to: "pages#full"
  get "/complete", to: "pages#complete"
end
