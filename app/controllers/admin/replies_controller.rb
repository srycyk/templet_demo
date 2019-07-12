
class Admin::RepliesController < ApplicationController
  include Templet::ViewerResponders

  before_action :set_category

  # GET /admin/categories/1/replies
  # GET /admin/categories/1/replies.json
  def index
    @questions = @category.questions.with_answers

    respond_to_index
  end

  # GET /admin/categories/1/replies/1
  # GET /admin/categories/1/replies/1.json
  def show
    @question = @category.questions.where(id: params[:id]).with_answers.first

    @question ||= @category.questions.find(params[:id]) # if no answers exist

    respond_to_show
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def model_name
    :question
  end

  # class_name: determines the viewer class
  # controller: selects the controller to use in the link sets
  # parent: same as the QuestionsController
  def viewer_options
    { class_name: :reply, controller: 'admin/questions', parent: :category }
  end
end
