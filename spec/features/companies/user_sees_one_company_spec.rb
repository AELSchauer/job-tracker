require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    job = create(:job)

    visit company_path(job.company)

    expect(current_path).to eq("/companies/#{job.company.id}")
    expect(page).to have_content(job.company.name)
    expect(page).to have_content(job.title)
  end
end