
class ListingController < ApplicationController
  include Templet::ViewerResponders

  # GET /listing
  # Only supports the format: html
  def index
    @listing = Question.with_answers

    # The viewer call resolves to:
    #   App::ListingViewer.new(self, :category, models: @listing).index
    #
    # +models+     is for the instance variable @listing
    # +model_name+ is for category links on navbar
    # +controller+ is nil to suppress links to this controller on navbar
    # +class_name+ is to name the Viewer class, i.e. ListingViewer,
    #              usually its taken from the controller (which is nil)
    render inline viewer(:index, models: :listing,
                                 model_name: :category,
                                 controller: nil,
                                 class_name: :listing)
  end
end

