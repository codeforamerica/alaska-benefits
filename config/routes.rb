Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Cfa::Styleguide::Engine => "/cfa"

  root "pages#index"
  get "/download", to: "pages#download"
  get "/consent", to: "pages#consent"
  get "/upload", to: "clients#new"
  get "/admin", to: "admin#index"
  get "/admin/clients/:id/pdf", to: "admin#pdf", as: "pdf"
  post "/admin/clients/:id/mail_pdf", to: "admin#mail_pdf", as: "mail_pdf"

  resources :clients
  resources :feedbacks, only: [:new, :create]




  get "/minimal", to: "pages#minimal"
  get "/full", to: "pages#full"
  get "/complete", to: "pages#complete"
end
