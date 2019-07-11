
require "rails_helper"
require 'rack/test/methods'

RSpec.describe Admin::QuestionsController, type: :api do
  it_behaves_like "a json controller" do
    let(:model_singular) { :question }

    let(:parent_name) { :category }

    let(:scope) { 'admin' }


    let(:field_name) { :query }
  end
end

