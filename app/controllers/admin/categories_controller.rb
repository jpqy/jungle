# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_HTTP_BASIC_AUTH_USERNAME'], password: ENV['ADMIN_HTTP_BASIC_AUTH_PASSWORD']
  def index
    @categories = Category.order(name: :asc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to %i[admin categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
