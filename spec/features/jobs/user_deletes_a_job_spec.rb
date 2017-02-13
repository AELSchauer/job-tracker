require 'rails_helper'

RSpec.feature "User deletes a job" do
  scenario "" do
    company = create(:company_with_jobs)
    job1, job2, job3 = company.jobs
    visit company_path(company)

    expect(page).to have_link(job1.title, href: job_path(job1.id))
    expect(page).to have_link(job2.title, href: job_path(job2.id))
    expect(page).to have_link(job3.title, href: job_path(job3.id))

    click_on job2.title
    click_on "Delete"

    expect(current_path).to eq(company_path(company))
    expect(page).to have_link(job1.title, href: job_path(job1.id))
    expect(page).to have_link(job3.title, href: job_path(job3.id))

    expect(page).to_not have_link(job2.title, href: job_path(job2.id))
    expect(page).to have_content("#{job2.title} at #{company.name} was successfully deleted!")
  end
end