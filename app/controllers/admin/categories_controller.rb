
class Admin::CategoriesController < ApplicationController
  include Templet::ViewerResponders

  before_action :set_category, only: %i(show edit update destroy)

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    @categories = Category.all

    respond_to_index
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
    respond_to_show
  end

  # GET /admin/categories/new
  def new
    @category = Category.new

    respond_to_new
  end

  # GET /admin/categories/1/edit
  def edit
    respond_to_edit
  end

  # POST /admin/categories/1
  # POST /admin/categories/1.json
  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to_save_success(@category, [:admin, :categories])
    else
      respond_to_save_failure(:new, @category)
    end
  end

  # PATCH/PUT /admin/categories/1
  # PATCH/PUT /admin/categories/1.json
  def update
    if @category.update(category_params)
      respond_to_save_success(@category, [:admin, :categories])
    else
      respond_to_save_failure(:edit, @category)
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.json
  def destroy
    @category.destroy

    respond_to_destroy(@category, [:admin, :categories])
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(*category_fields)
  end

  def category_fields
    %i(name)
  end

  def viewer_options
    super.merge({  })
  end
end
