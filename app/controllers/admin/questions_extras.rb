
# Prepended to QuestionsController
module Admin::QuestionsExtras
  # GET /questions
  # GET /questions.json
  def index
    @questions = @category.questions.ready.query(*query_args)

    query_message

    respond_to_index
  end

  # GET /questions/disused
  # GET /questions/disused.json
  def disused
    @questions = @category.questions.disused.query(*query_args)

    query_message

    if latest = @category.questions.disused.latest.first
      @latest_change = latest.updated_at.localtime.to_s :short
    end

    respond_to_action :disused, models: :questions, variables: %i(latest_change)
  end

  # PUT /questions/1/reinstate
  def reinstate
    if not set_question.in_disuse?
      flash[:notice] = "Question is already available"
    elsif @question.reinstate
      flash[:notice] = "Question now in use"
    else
      flash[:error] = "Question NOT updated"
    end

    redirect_to [:admin, @category, @question]
  end

  private

  def query_args
    params.values_at(:by, :page, :q)
  end

  def query_message
    if params[:q].present?
      flash.now[:notice] = "Search results for '#{params[:q]}'"
    end
  end
end
