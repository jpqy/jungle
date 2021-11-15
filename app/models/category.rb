# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_many :products
  validates :name, presence: true, uniqueness: true

  before_validation :titleize_name

  private

  def titleize_name
    self.name = name.titleize
  end
end
