
module App
  class Admin::QuestionViewer < BaseViewer
    # Overrides the default action index,
    #  adding extras below the usual table() call
    def index
      # This method (wrap_action) determines what to use as the layout
      wrap_action :index do |renderer|
        in_rows renderer,
                table(renderer),
                search_form(renderer),
                recent_link(renderer)
      end
    end

    # Overrides the default for the action show,
    #   which usually is just a call to list()
    def show
      wrap_action :show do |renderer|
        in_rows renderer,
                list(renderer),
                (model.in_disuse? ? reinstate_link(renderer) : nil)
      end
    end

    # This handles an additional controller action
    # An instance variable @latest_change was passed by the controller
    def disused
      # You can omit wrap_action's parameter: :disused - but it's slower
      wrap_action do |renderer|
        in_rows renderer,
                table(renderer),
                search_form(renderer, action: :disused),
                renderer.() { [ strong('Latest change: '), em(latest_change)
 ] }
      end
    end

    private

    # Extra menu for links to added action (disused)
    # and for links to another controller (replies)
    def sidebar_links_class
      App::Layouts::Panel::SidebarQuestionsLinks
    end

    # An HTML form containing a text field for searching through questions
    def search_form(renderer, **options)
      options.reverse_merge! scope: namespace, remote: remote?

      Templet::Utils::HtmlSearchForm.(renderer, model, parent, **options)
    end

    # A link to a list with the most recently changed records at the top
    def recent_link(renderer)
      link_procs = rest_link_procs BS_BUTTON_BLOCK

      proc_index_link_with_params(link_procs, 'Most recent', by: 'recent')
          .(renderer, model, parent)
    end

    # A link to a further action that nullifies expires_on and makes active
    def reinstate_link(renderer)
      link_procs = rest_link_procs BS_BUTTON_BLOCK

      opts = { method: :put, remote: false, data: { confirm: 'Okay?' } }

      link_procs.link_by_action(:reinstate, opts: opts)
                .(renderer, model, parent)
    end

    # Specifies the fields that are shown for the actions: index & disused
    # Used internally in the two table() calls above
    def index_controls
      # The first few table column titles are actually HTML links
      # The links add a param called 'by' whose value is a name to sort by
      if action? :index
        field_names = %i(query expires_on)

        procs_by_name = index_controls_sortable_hash(field_names, :by)
      elsif action? :disused
        field_names = %i(query active expires_on)

        procs_by_name = index_controls_sortable_hash(field_names, :by,
                                                     action: action)

        procs_by_name[:expired] = proc_call_method_format(:expired?)
      end

      # Since method answers_count returns an Integer, it'll be right justified
      procs_by_name[:answers] = proc_call_method_format(:answers_count)

      # Use ordinary (textual) links, overriding the default which are buttons
      link_procs = rest_link_procs %i(link md)

      # A link to the index action showing related answers - aligned rightwards
      forward_link(link_procs, to: procs_by_name) {|link| pull_right_proc link }

      # The super call appends links for the actions: show edit destroy
      super link_procs, procs_by_name
    end

    # Method (field) names used in the list() call for the show action
    def show_controls
      super %i(query category active? answers_count in_disuse?
               expired? expires_on created_at updated_at)
    end

    # Used in the form() call in the superclass actions: new & edit
    def html_form(*)
      super do |field|
        [ field.text_area(:query, rows: 3, mandatory: true),
          field.select(:category_id, Category.all, size: 3),
          field.check_box_inline(:active),
          field.date(:expires_on),
          field.submit
        ]
      end
    end

    # Use the JS format (AJAX) for all actions
    def remote?
      true
    end

      # Used in button groups for links to a model's children
      def forward
        :answers
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
