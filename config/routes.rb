
Rails.application.routes.draw do
  namespace('admin') do
    resources(:categories, only: []) { resources(:replies, only: %i(index show)) }
  end
  namespace('admin') do
    resources(:questions, only: []) { resources(:answers) }
  end
  namespace('admin') do
    resources(:categories, only: []) { resources(:questions) }
  end
  namespace('admin') do
    resources(:categories)
  end
  mount TempletRails::Engine, at: '/templet'

  # Manually added - not generated
  root to: 'admin/categories#index'
end
