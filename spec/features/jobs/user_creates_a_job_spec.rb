require 'rails_helper'

RSpec.feature "User creates a new job" do
  scenario "with all fields filled in" do
    company = create(:company)
    category = create(:category)
    visit company_path(company)

    click_link "Create Job"

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    select category.title, from: "job[category_id]"
    click_button "Submit"

    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_link(company.name, href: company_path(company))
    expect(page).to have_content("So fun!")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
    expect(page).to have_content(category.title)
    expect(page).to have_content("Developer at #{company.name} was successfully created!")
  end

  scenario "with only required fields filled in" do
    company = create(:company)
    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    click_button "Submit"

    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
    expect(find("#description")).to have_content("")
    expect(find("#category")).to have_content("")
  end

  context "user submits an invalid form" do
    scenario "with 'title' left blank" do
      company = create(:company)
      visit new_company_job_path(company)

      fill_in "job[level_of_interest]", with: 80
      fill_in "job[city]", with: "Denver"
      click_button "Submit"

      expect(page).to have_content("Title can't be blank")
    end

    scenario "with 'level of interest' left blank" do
      company = create(:company)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[city]", with: "Denver"
      click_button "Submit"

      expect(page).to have_content("Level of interest")
    end

    scenario "with 'city' left blank" do
      company = create(:company)
      visit new_company_job_path(company)

      fill_in "job[title]", with: "Developer"
      fill_in "job[level_of_interest]", with: 80
      click_button "Submit"

      expect(page).to have_content("City can't be blank")
    end
  end
end
