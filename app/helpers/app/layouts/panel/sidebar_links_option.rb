
module App
  module Layouts
    module Panel
      module SidebarLinksOption
        private

        def panel_options(renderer=nil, **options)
          super renderer, options.merge(sidebar_cols: nil,
                                        sidebar_content: sidebar_links(renderer))
        end

        def sidebar_links(renderer)
          Templet::Utils::LinkSetFactoryWrapper
            .new(renderer, action, sidebar_links_class)
            #.(:toolbar, stacked: true)
        end

        def sidebar_links_class
          Templet::Links::BsLinkSetNavigation
        end
      end
    end
  end
end

