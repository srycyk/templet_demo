
module App
  module Layouts
    # Renders a navbar, flash messages and yielded content in Bootstrap grid
    class LayoutBase < Templet::Component::Partial
      include Templet::Mixins::Bs::Grid

      def call(action, **options)
        super() do
          js_target_div :outer,
                        navbar(*options[:nav_args]),
                        messages,
                        in_rows(renderer, yield(renderer), **bs_column_opts)
        end
      end

      private

      # Adds a surrounding div tag, whose content is replaced in JS requests
      def js_target_div(suffix, *content)
        renderer.call do
          div(id: "panel-#{suffix}") { content }
        end
      end

      def bs_column_opts
        { cols: 10, offset: 1 }
      end

      def messages
        Panel::FlashMessages.new(renderer).(**bs_column_opts)
      end

      def navbar(*args)
        Navbar.new(renderer).(*args)
      end
    end
  end
end

