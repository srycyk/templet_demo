
module App
  module Layouts
    module Panel
      # Shows flash messages in a Bootstrap alert - inside a Bootstrap grid
      class FlashMessages < Templet::Component::Partial
        include Templet::Mixins::Bs::Grid

        BUTTON_ATTS = { class: "close",
                        data_dismiss: "alert",
                        aria_hidden: "true" }

        def call(**column_opts)
          super() do
            if flash.any?
              in_rows renderer, **column_opts do
                flash.map do |name, message|
                  if message.is_a?(String)
                    alert_name = name.to_s == 'notice' ? 'success' : 'danger'

                    div "alert alert-dismissible alert-#{alert_name}" do
                      [ button('&times;', BUTTON_ATTS),
                        div(message, id: "flash_#{name}") ]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

