#! /bin/bash

# Deletes every file created by running the scripts: install.sh & scaffold.sh

rails g templet:destroy --all

if [ -d "app/controllers/admin" ]; then
  [[ -f "app/controllers/admin/categories_controller.rb" ]] && rm app/controllers/admin/categories_controller.rb

  [[ -f "app/controllers/admin/questions_controller.rb" ]] && rm app/controllers/admin/questions_controller.rb

  [[ -f "app/controllers/admin/answers_controller.rb" ]] && rm app/controllers/admin/answers_controller.rb

  [[ -f "app/controllers/admin/replies_controller.rb" ]] && rm app/controllers/admin/replies_controller.rb

  rmdir app/controllers/admin/
fi
