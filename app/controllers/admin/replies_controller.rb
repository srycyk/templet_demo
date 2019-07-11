
class Admin::RepliesController < ApplicationController
  include Templet::ViewerResponders

  before_action :set_category

  before_action :set_question, only: %i(show)

  # GET /admin/categories/1/replies
  # GET /admin/categories/1/replies.json
  def index
    @questions = @category.questions.all

    respond_to_index
  end

  # GET /admin/categories/1/replies/1
  # GET /admin/categories/1/replies/1.json
  def show
    respond_to_show
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_question
    @question = @category.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(*question_fields)
  end

  def question_fields
    %i(query active expires_on category_id)
  end

  def model_name
    :question
  end

  def viewer_options
    super.merge({ parent: :category })
  end
end
