# frozen_string_literal: true

class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_HTTP_BASIC_AUTH_USERNAME'], password: ENV['ADMIN_HTTP_BASIC_AUTH_PASSWORD']
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
