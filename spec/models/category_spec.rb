require 'rails_helper'

RSpec.describe Category, type: :model do
  let (:category) { create :category }

  it 'sets query' do
    expect(category.name).to eq 'Category name'
  end
end
