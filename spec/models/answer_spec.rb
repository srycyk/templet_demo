require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { create :answer }

  it 'exists' do
    expect(answer).to be_instance_of Answer
  end
end
