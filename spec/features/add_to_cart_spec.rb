require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end

    scenario "They see cart increses by one each time 'add to Cart' is clicked" do
      visit root_path
      click_on 'Add'
  
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  
      # commented out b/c it's for debugging only
      # save_and_open_screenshot
  
      # expect(page).to have_css 'article.product', count: 10
      expect(page).to have_content('My Cart (1)')
    end

end
