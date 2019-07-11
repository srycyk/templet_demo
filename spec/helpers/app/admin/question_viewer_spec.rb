
require "rails_helper"

RSpec.describe App::Admin::QuestionViewer, type: :helper do
  it_should_behave_like "a viewer" do
    let(:model_name) { :question }

    let(:parent_name) { :category }

    let(:scope) { 'admin' }


    let(:field_name) { :query }

    let(:input_field_tag) { "textarea" }
  end
end

