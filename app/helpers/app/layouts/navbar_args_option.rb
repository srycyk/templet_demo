
module App
  module Layouts
    #module Panel
      module NavbarArgsOption
        private

        def panel_options(renderer=nil, **options)
          super renderer, options.merge(nav_args: nav_args(renderer))
        end

        def nav_args(renderer)
          return page_title, navbar_links(renderer)
        end

        def navbar_links(renderer)
          Templet::Utils::LinkSetFactory
            .new(renderer, action, navbar_links_class, navbar_links_options)
        end

        def navbar_links_class
          App::Layouts::NavbarLinks
        end

        def navbar_links_options
          { html_class: '', remote: nil, wrapper: :li }
        end
      end
    #end
  end
end

