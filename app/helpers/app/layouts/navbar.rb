
module App
  module Layouts
    # Renders a Bootstrap navbar, with a title and some links on right
    class Navbar < Templet::Component::Partial
      NAVBAR_CLASS = "navbar navbar-default"
      BUTTON_ID = "bs-navbar-collapse-1"

      def call(title, links, before: nil, after: nil)
        super() do
          nav role: "navigation", class: NAVBAR_CLASS do
            div "container-fluid"  do
              [ nav_header(title),
                before,
                nav_collapse(links),
                after ]
            end
          end
        end
      end

      private

      def nav_header(title)
        brand_atts = { class: 'navbar-brand', style: 'font-size: large' }

        renderer.call do
          div "navbar-header page-scroll" do
            [ button(button_spans, button_atts),
              link_to(title, root_path, brand_atts) ]
          end
        end
      end
      def button_spans
        "<span class='sr-only'>Toggle navigation</span>\n" +
          "<span class='icon-bar'></span>\n" * 3
      end
      def button_atts
        { type: 'button',  class: "navbar-toggle",
          data_toggle: "collapse", data_target: "##{BUTTON_ID}" }
      end

      def nav_collapse(links)
        if links
          renderer.call do
            div "collapse navbar-collapse", id: BUTTON_ID do
              ul links, "nav navbar-nav navbar-right"
            end
          end
        end
      end
    end
  end
end

