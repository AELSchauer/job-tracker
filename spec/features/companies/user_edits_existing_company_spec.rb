require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user can edit a company" do
    company = create(:company)
    visit edit_company_path(company)

    expect(current_path).to eq("/companies/#{company.id}/edit")

    fill_in "company[name]", with: "EA Sports"
    click_button "Submit"

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("EA Sports was successfully updated!")
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content(company.name)
  end

  context "they submit an invalid form" do
    scenario "they leave 'name' blank" do
      company = create(:company)
      visit edit_company_path(company)

      fill_in "company[name]", with: ""
      click_button "Submit"

      expect(page).to have_content("Name can't be blank")
    end
    scenario "they enter in a duplicate 'name'" do
      company1 = create(:company)
      company2 = create(:company)
      visit edit_company_path(company2)

      fill_in "company[name]", with: company1.name
      click_button "Submit"

      expect(page).to have_content("Name has already been taken")
    end
  end
end
