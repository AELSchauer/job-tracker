require "rails_helper"

RSpec.feature "User edits a category..." do
  scenario "They visit the new category page and fill out the form" do
    category = Category.create(title: "Backend Development")
    edit_category_title = "Full Stack Development"

    visit categories_path

    click_on "Edit"

    expect(page).to have_current_path(edit_category_path(category))

    fill_in "category_title", with: edit_category_title
    click_on "Submit"

    expect(page).to have_content(edit_category_title)
  end

  context "user submits an invalid form" do
    scenario "user enters a title that already exists" do
      category1 = Category.create(title: "Frontend Development")
      category2 = Category.create(title: "Backend Development")

      visit edit_category_path(category2)

      fill_in "category_title", with: category1.title
      click_on "Submit"

      expect(page).to have_content("Title has already been taken")
    end

    scenario "user leaves 'title' blank" do
      category = Category.create(title: "Backend Development")

      visit edit_category_path(category)

      click_on "Submit"

      expect(page).to have_content("Title can't be blank")
    end
  end
end


