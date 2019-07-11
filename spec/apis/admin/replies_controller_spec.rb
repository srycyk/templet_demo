
require "rails_helper"
require 'rack/test/methods'

=begin
RSpec.describe Admin::RepliesController, type: :api do
  it_behaves_like "a json controller", %i(index show) do
    let(:model_singular) { :question }

    let(:parent_name) { :category }

    let(:scope) { 'admin' }

    let(:controller_name) { 'replies' }


    let(:field_name) { :query }
  end
end

=end
