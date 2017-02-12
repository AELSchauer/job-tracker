require "rails_helper"

RSpec.feature "User edits an existing category" do
  scenario "" do
    category = create(:category)
    visit categories_path

    click_on "Edit"

    expect(page).to have_current_path("/categories/#{category.id}/edit")

    fill_in "category_title", with: "Full Stack Development"
    click_on "Submit"

    expect(page).to have_content("Full Stack Development")
    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content("Full Stack Development was successfully updated!")
  end

  context "user submits an invalid form" do
    scenario "user enters a title that already exists" do
      category1, category2 = create_list(:category, 2)
      visit edit_category_path(category2)

      fill_in "category_title", with: category1.title
      click_on "Submit"

      expect(page).to have_content("Title has already been taken")
    end

    scenario "user leaves 'title' blank" do
      category = create(:category)
      visit edit_category_path(category)

      fill_in "category_title", with: ""
      click_on "Submit"

      expect(page).to have_content("Title can't be blank")
    end
  end
end


