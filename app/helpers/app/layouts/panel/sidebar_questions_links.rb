
module App
  module Layouts
    module Panel
      class SidebarQuestionsLinks < Templet::Links::BsLinkSetNavigation
        def call(action=nil)
          super.tap do |links|
            disused_link(links, action)

            if model.respond_to?(:persisted?) and model.persisted?
              reply_link(links, action)
            end

            replies_link(links, action)
          end
        end

        private

        def disused_link(links, action)
          push_in links, link_proc_by_action_selected(:disused, action,
                                                      on_collection: true)
        end

        def reply_link(links, action)
          path = rest_path(controller: :replies).show

          push_in links, link_proc_by_path_selected(:reply, action, path,
                                                    'Replies', 'With answers')
        end

        def replies_link(links, action)
          path = rest_path(controller: :replies).index

          push_in links, link_proc_by_path_selected(:replies, action, path,
                                                    'All replies',
                                                    'Questions with answers')
        end
      end
    end
  end
end

