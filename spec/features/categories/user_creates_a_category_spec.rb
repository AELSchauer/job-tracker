require "rails_helper"

RSpec.feature "User creates a category" do
  scenario "" do
    visit categories_path

    click_on "Create Category"

    expect(page).to have_current_path("/categories/new")

    fill_in "category_title", with: "Web Development"
    click_on "Submit"

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("Web Development was successfully created!")
    expect(page).to have_content("Web Development")
    expect(Category.count).to eq(1)
  end

  context "user submits an invalid form" do
    scenario "user enters a title that already exists" do
      category = create(:category)
      visit new_category_path

      fill_in "category_title", with: category.title
      click_on "Submit"

      expect(page).to have_content("Title has already been taken")
    end

    scenario "user leaves 'title' blank" do
      visit categories_path
      click_on "Create Category"

      click_on "Submit"

      expect(page).to have_content("Title can't be blank")
    end
  end
end


