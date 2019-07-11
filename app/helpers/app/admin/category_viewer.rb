
module App
    class Admin::CategoryViewer < BaseViewer

      private

      # Used in button groups for links to a model's children
      def forward
        :questions
      end


      # You can override the following methods:
      #
      # remote?     For AJAX links and forms
      # form_height For the field height on the form (sm md lg)
      # forward     For the model's principal has_many relationship
      # backward    For the model's grand-parent
      #             This can be overriden in the controller
      #
      # There are also a number of others, mostly to do with the layout
      #
      # For more info see: app/helpers/templet/viewer_base.rb
      #                    app/helpers/templet/viewer_rest.rb
    end
end
