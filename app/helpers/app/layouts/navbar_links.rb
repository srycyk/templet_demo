
module App
  module Layouts
    class NavbarLinks < Templet::Links::BsLinkSetCollection
      def call(action=nil)
        super.tap do |links|
        end
      end
    end
  end
end

