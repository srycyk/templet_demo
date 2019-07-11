
module App
  class Admin::CategoryViewer < BaseViewer
    private

    # Titles and fields to display for the index action,
    #   basically, the main HTML table.
    # This method is called internally by the method table(),
    #   which is also passed an array of models.
    def index_controls
      # The table's contents are defined in an ordinary Ruby Hash.
      # The named key is the table's column title
      # Its corresponding value is a Proc, which is called with
      # an instance of a model and, if applicable, that model's parent
      # These procs call a method on the passed model
      # whose return value is displayed
      #
      { name: proc_call_method(:name),
        questions: proc_call_method(:questions_count),
        answers: proc_call_method(:answers_count),
        _questions: forward_link, # a link to corresponding questions
        **member_links_hash_as_icons # links (show edit destroy) will be icons
      }
    end

    # Fields to display for the action: show, i.e. in the HTML list <dl>
    def show_controls
      super %i(name questions_count answers_count created_at updated_at)
    end

    # Form controls

    # Specifies the input fields on the form
    def html_form(*)
      super {|field| [ field.text(:name, mandatory: true), field.submit ] }
    end

    # Makes the input fields (on forms) bigger
    def form_height
      'lg'
    end

    # Use the JS format (AJAX)
    def remote?
      true
    end

    # The remaining was generated
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
