require 'rails_helper'

RSpec.feature "User edits an existing job" do
  scenario "with all fields changed" do
    job = create(:job)
    category = create(:category)

    visit job_path(job)

    click_link "Edit"

    fill_in "job[title]", with: "Sumo Wrestler"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 101
    fill_in "job[city]", with: "Denver"
    select category.title, from: "job[category_id]"
    click_button "Submit"

    expect(current_path).to eq("/jobs/#{job.id}")
    expect(page).to have_content("Sumo Wrestler")
    expect(page).to have_content("So fun!")
    expect(page).to have_content("101")
    expect(page).to have_content("Denver")
    expect(page).to have_content(category.title)
    expect(page).to have_content("Sumo Wrestler at #{job.company.name} was successfully updated!")
  end

  scenario "with only required fields filled in" do
    job = create(:job)

    visit edit_company_job_path(job.company, job)

    fill_in "job[description]", with: ""
    select "", from: "job[category_id]"
    click_button "Submit"

    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
    expect(page).to have_content(job.city)
    expect(find("#description")).to have_content("")
    expect(find("#category")).to have_content("")
  end

  context "user submits an invalid form" do
    scenario "with 'title' left blank" do
      job = create(:job)

      visit edit_company_job_path(job.company, job)

      fill_in "job[title]", with: ""
      click_button "Submit"

      expect(page).to have_content("Title can't be blank")
    end

    scenario "with 'level of interest' left blank" do
      job = create(:job)

      visit edit_company_job_path(job.company, job)

      fill_in "job[level_of_interest]", with: ""
      click_button "Submit"

      expect(page).to have_content("Level of interest")
    end

    scenario "with 'city' left blank" do
      job = create(:job)

      visit edit_company_job_path(job.company, job)

      fill_in "job[city]", with: ""
      click_button "Submit"

      expect(page).to have_content("City can't be blank")
    end
  end
end