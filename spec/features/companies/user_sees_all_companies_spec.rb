require 'rails_helper'

describe "User sees a list of all companies" do
  scenario "a user sees all the companies" do
    company1, company2, company3, company4 = create_list(:company, 4)

    visit companies_path

    comp1 = page.find("#company-#{company1.id}")
    expect(comp1).to have_link(company1.name, href: company_path(company1))
    expect(comp1).to have_link("Edit", href: edit_company_path(company1))

    comp2 = page.find("#company-#{company2.id}")
    expect(comp2).to have_link(company2.name, href: company_path(company2))
    expect(comp2).to have_link("Edit", href: edit_company_path(company2))

    comp3 = page.find("#company-#{company3.id}")
    expect(comp3).to have_link(company3.name, href: company_path(company3))
    expect(comp3).to have_link("Edit", href: edit_company_path(company3))

    comp4 = page.find("#company-#{company4.id}")
    expect(comp4).to have_link(company4.name, href: company_path(company4))
    expect(comp4).to have_link("Edit", href: edit_company_path(company4))
  end

end
