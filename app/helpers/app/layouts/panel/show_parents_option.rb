
module App
  module Layouts
    module Panel
      module ShowParentsOption
        private

        def panel_options(renderer=nil, **options)
          super renderer, options.merge(header_right: show_parents(renderer))
        end

        def show_parents(renderer)
          if respond_to?(:parent) and parent
            parent_list = Templet::Utils::ListModelParents.new
                            .in_html(parent, [*grand_parent])

            in_html_list(renderer, parent_list, html_class: :stacked)
          end
        end
      end
    end
  end
end

