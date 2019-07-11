#! /bin/bash

# Generates scaffolding for the pre-defined models: Category, Question & Answer
# The scaffolding consists of a Rails controller, a Viewer class,
# two rspec tests, and in-line additions to config/routes.rb
# The controllers are given a namespace of 'admin' - unlike the models

rails generate templet:scaffold admin/category --child question --no-comment-tests --add-routes

rails generate templet:scaffold admin/question --parent category --child answer --no-comment-tests --add-routes

# The Answer model has no Viewer class as it uses the base viewer class
# which is Templet::ApplicationRestViewer
rails generate templet:controller admin/answer --parent question --grand-parent category --add-routes # Create a controller
rails generate templet:rspec admin/answer --parent question --no-viewer-tests -no-comment-tests # Create JSON tests for the generated controller
rails generate templet:routes admin/answer --parent question --add-routes

# A different controller that uses the Question model internally
rails generate templet:scaffold admin/reply --model question --parent category --add-routes --actions index show # Restrict to just two controller actions

# Generator options:
#   comment-tests puts block comments around the code in the test scripts
#   add-routes    actually writes the generated routes to config/routes.rb
#   child         is the record name of the model's descendants
#   parent        is the record name that the model belongs to
#   grand-parent  is the record name that the parent belongs to
#   model         is the record name of the model - to be used if this is
#                 different to the name given as the first argument
#   actions       are a list of REST actions to be defined in the controller

