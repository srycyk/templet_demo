
module App
  module Layouts
    # Renders a heading with a title, subtitle and perhaps something on right
    class LayoutHeader < LayoutBase
      def call(action, **options)
        args = options.values_at :title, :subtitle, :header_right

        super { [ header(*args), yield(renderer) ] }
      end

      private

      def header(title, subtitle, on_right)
        renderer.call do
          div :page_header do
            [ div(on_right, :pull_right), h1([title, small(subtitle)]) ]
          end
        end
      end
    end
  end
end

