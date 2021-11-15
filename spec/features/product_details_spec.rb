# frozen_string_literal: true

require 'rails_helper'
require 'images'

RSpec.feature 'Visitor navigates from home page to product page', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They can click on a product and go to the product page' do
    visit root_path

    # Wait for page to render the 10 products
    expect(page).to have_css 'article.product', count: 10
    product = Product.last
    click_on product.name

    # VERIFY
    expect(page).to have_css 'section.products-show'
  end
end
