Rails.application.routes.draw do
  Rails.application.routes.draw do
    resources :teams do
      get :members, on: :member

      resources :members, shallow: true do
        post :add_project, on: :member
      end
    end

    resources :projects
  end
end
