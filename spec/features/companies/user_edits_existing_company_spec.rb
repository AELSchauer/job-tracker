require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user can edit a company" do
    company = create(:company)

    visit edit_company_path(company)

    fill_in "company[name]", with: "EA Sports"
    click_button "Submit"

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content("EA Sports was successfully updated!")
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content(company.name)
  end
end
