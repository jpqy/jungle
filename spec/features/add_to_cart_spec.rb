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

    # Verify nothing is in the cart
    expect(page).to have_text 'My Cart (0)'

    # Click on add to cart on first product
    within 'article.product:nth-child(1)' do
      click_button 'Add'
    end

    # Verify that My Cart has (1) in the nav bar
    expect(page).to have_text 'My Cart (1)'

    # Click on add to cart on second product
    within 'article.product:nth-child(2)' do
      click_button 'Add'
    end
    expect(page).to have_text 'My Cart (2)'
  end
end
