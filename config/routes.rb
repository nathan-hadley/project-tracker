Rails.application.routes.draw do
  resources :members do
    post :add_project, on: :member
  end

  resources :teams do
    get :members, on: :member
  end

  resources :projects
end
