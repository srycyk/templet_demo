
module App
  class Admin::ReplyViewer < BaseViewer
    def index
      wrap_action :replies do |renderer|
        models.map {|question| reply_in_html(renderer, question) }
      end
    end

    def show
      wrap_action :reply do |renderer|
        reply_in_html(renderer, model)
      end
    end

    private

    def reply_in_html(renderer, question)
      renderer.call do
        [ h3(question, :text_center),
          question.answers.map do |answer|
            blockquote _p [ answer, small(answer.by) ]
          end
        ]
      end
    end

    def panel_options(renderer, **)
      super renderer, subtitle: 'Answered'
    end

    def sidebar_links_class
      App::Layouts::Panel::SidebarQuestionsLinks
    end
  end
end
