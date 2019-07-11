
require "rails_helper"

=begin
RSpec.describe App::Admin::ReplyViewer, type: :helper do
  it_should_behave_like "a viewer", %i(index show) do
    let(:model_name) { :question }

    let(:parent_name) { :category }

    let(:scope) { 'admin' }

    let(:controller_name) { 'replies' }


    let(:field_name) { :query }

    let(:input_field_tag) { "textarea" }
  end
end

=end
