
module App
  module Layouts
    module OptionsConfig
      include NavbarArgsOption

      include Panel::SidebarLinksOption

      include Panel::ShowParentsOption

      private

      def panel_class
        App::Layouts::LayoutHeaderSidebar
      end
    end
  end
end

