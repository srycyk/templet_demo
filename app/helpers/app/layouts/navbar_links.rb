
module App
  module Layouts
    class NavbarLinks < Templet::Links::BsLinkSetCollection
      def call(action=nil)
        super.tap do |links|
          path = renderer.listing_path # Call to Rails route method

          title = 'Show all questions with answers'

          link = link_proc_by_path_selected(:listing, action, path,
                                            nil, title, remote: false)

          links.unshift link if link
        end
      end
    end
  end
end

