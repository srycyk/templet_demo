
require "rails_helper"
require 'rack/test/methods'

=begin
RSpec.describe Admin::AnswersController, type: :api do
  it_behaves_like "a json controller" do
    let(:model_singular) { :answer }

    let(:parent_name) { :question }

    let(:scope) { 'admin' }


    let(:field_name) { :reply }
  end
end

=end
