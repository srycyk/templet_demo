
module App
    class Admin::ReplyViewer < BaseViewer

      # For showing links to member actions (show edit destroy) in table rows
      def index_controls
        links = default_rest_link_procs.member_link_hash %i(_show)

        hash_field_name_by_proc_call_method_default.merge links
      end

      private


      # Checks whether a REST link is actually defined before displaying it
      def verify_rest_links?
        true
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
