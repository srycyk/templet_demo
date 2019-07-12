
module App
  class ListingViewer < BaseViewer
    def index
      # This action's only for the HTML format,
      # so layout is used instead of wrap_action
      layout :listing do |renderer|
        html_definition_list renderer, title_by_html_list(renderer, models)
      end
    end

    private

    def title_by_html_list(renderer, questions)
      questions.reduce Hash.new do |acca, question|
        title = "#{question} <em class='small'>(#{question.category})</em>"

        answers = question.answers.map(&:to_s).sort!

        acca.merge title => html_list(renderer, answers, html_class: :stacked)
      end
    end

    # To suppress the sidebar menu for this controller action
    def panel_class
      Layouts::LayoutHeader
    end

    # Overrides the default titles in the Bootstrap header
    def panel_options_default
      { title: 'Questions &amp; Answers', subtitle: 'in full' }
    end

    # So that navbar links are namespaced
    def scope
      :admin
    end
  end
end

