
module App
  module Layouts
    module Panel
      class SidebarQuestionsLinks < Templet::Links::BsLinkSetNavigation
        def call(action=nil)
          super.tap do |links|
            disused_link(links, action)
          end
        end

        private

        def disused_link(links, action)
          push_in links, link_proc_by_action_selected(:disused, action,
                                                      on_collection: true)
        end
      end
    end
  end
end

