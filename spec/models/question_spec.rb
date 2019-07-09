require 'rails_helper'

RSpec.describe Question, type: :model do
  let (:question) { create :question }

  it 'sets name' do
    expect(question.query).to eq 'Query text'
  end
end
