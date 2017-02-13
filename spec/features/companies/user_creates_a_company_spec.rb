require 'rails_helper'

describe "User creates a new company" do
  scenario "..." do
    visit new_company_path

    expect(current_path).to eq("/companies/new")

    fill_in "company[name]", with: "ESPN"
    click_button "Submit"

    expect(current_path).to eq("/companies/#{Company.last.id}")
    expect(page).to have_content("ESPN was successfully created!")
    expect(page).to have_content("ESPN")
    expect(Company.count).to eq(1)
  end

  context "they submit an invalid form" do
    scenario "they leave 'name' blank" do
      visit new_company_path

      click_button "Submit"

      expect(page).to have_content("Name can't be blank")
    end
    scenario "they enter in a duplicate 'name'" do
      company = create(:company)
      visit new_company_path

      fill_in "company[name]", with: company.name
      click_button "Submit"

      expect(page).to have_content("Name has already been taken")
    end
  end
end
