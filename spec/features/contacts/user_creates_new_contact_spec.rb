require 'rails_helper'

RSpec.feature "User creates a new contact" do
  scenario "..." do
    company = create(:company)

    visit company_path(company)

    click_on "Create Contact"
    expect(current_path).to eq("/companies/#{company.id}/contacts/new")

    fill_in "contact[first_name]", with: "Bert"
    fill_in "contact[last_name]", with: "Macklin"
    fill_in "contact[position]", with: "FBI Agent"
    fill_in "contact[email]", with: "agent.macklin@fbi.gov"
    click_on "Submit"

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content("Contacts")
    expect(page).to have_content("Bert Macklin")
    expect(page).to have_content("FBI Agent")
    expect(page).to have_content("agent.macklin@fbi.gov")
    expect(Contact.count).to eq(1)
  end

  context "user submits an invalid form" do
    scenario "user leaves 'first name' empty" do
      company = create(:company)
      visit new_company_contact_path(company)

      fill_in "contact[last_name]", with: "Macklin"
      fill_in "contact[position]", with: "FBI Agent"
      fill_in "contact[email]", with: "agent.macklin@fbi.gov"
      click_on "Submit"

      expect(page).to have_content("First name can't be blank")
    end

    scenario "user leaves 'last name' empty" do
      company = create(:company)
      visit new_company_contact_path(company)

      fill_in "contact[first_name]", with: "Bert"
      fill_in "contact[position]", with: "FBI Agent"
      fill_in "contact[email]", with: "agent.macklin@fbi.gov"
      click_on "Submit"

      expect(page).to have_content("Last name can't be blank")
    end

    scenario "user leaves 'position' empty" do
      company = create(:company)
      visit new_company_contact_path(company)

      fill_in "contact[first_name]", with: "Bert"
      fill_in "contact[last_name]", with: "Macklin"
      fill_in "contact[email]", with: "agent.macklin@fbi.gov"
      click_on "Submit"

      expect(page).to have_content("Position can't be blank")
    end

    scenario "user leaves 'email' empty" do
      company = create(:company)
      visit new_company_contact_path(company)

      fill_in "contact[first_name]", with: "Bert"
      fill_in "contact[last_name]", with: "Macklin"
      fill_in "contact[position]", with: "FBI Agent"
      click_on "Submit"

      expect(page).to have_content("Email can't be blank")
    end
  end
end