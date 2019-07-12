
Rails.application.routes.draw do
  mount TempletRails::Engine, at: '/templet'

  namespace('admin') do
    resources :categories do
      resources :questions do
        get :disused, on: :collection

        put :reinstate, on: :member
      end
      resources :replies, only: %i(index show), format: /html|js/
    end
    resources(:questions, only: []) { resources :answers }
  end

  root to: 'admin/categories#index'
end
