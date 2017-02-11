require "rails_helper"

RSpec.feature "User creates a category" do
  scenario "when visiting the new category page" do
    new_category_title = "Web Development"

    visit categories_path

    click_on "Create Category"

    expect(page).to have_current_path(new_category_path)

    fill_in "category_title", with: new_category_title
    click_on "Submit"

    expect(page).to have_content(new_category_title)
  end

  context "user submits an invalid form" do
    scenario "user enters a title that already exists" do
      category = Category.create(title: "Web Development")

      visit new_category_path

      fill_in "category_title", with: category.title
      click_on "Submit"

      expect(page).to have_content("Title has already been taken")
    end

    scenario "user leaves 'title' blank" do
      visit categories_path

      click_on "Create Category"

      expect(page).to have_current_path(new_category_path)

      click_on "Submit"

      expect(page).to have_content("Title can't be blank")
    end
  end
end


