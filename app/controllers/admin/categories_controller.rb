class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_HTTP_BASIC_AUTH_USERNAME'], password: ENV['ADMIN_HTTP_BASIC_AUTH_PASSWORD']
  def index
  end

  def new
  end
end
