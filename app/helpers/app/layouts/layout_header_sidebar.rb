
module App
  module Layouts
    # Renders a given sidebar
    class LayoutHeaderSidebar < LayoutHeader
      def call(action, **options)
        side_cols = options[:sidebar_cols] || 2
        main_cols = 12 - side_cols

        super do
          in_cols renderer, side_cols => options[:sidebar_content],
                            main_cols => js_target_div(:inner, *yield(renderer))
        end
      end

    end
  end
end

