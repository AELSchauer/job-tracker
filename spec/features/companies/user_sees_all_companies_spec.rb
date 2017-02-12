require 'rails_helper'

describe "User sees a list of all companies" do
  scenario "a user sees all the companies" do
    company1, company2 = create_list(:company, 2)

    visit companies_path

    expect(page).to have_content(company1.name)
    expect(page).to have_content(company2.name)
  end

end
