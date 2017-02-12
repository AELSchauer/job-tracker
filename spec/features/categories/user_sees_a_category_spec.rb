require 'rails_helper'

RSpec.feature "User sees a single category" do
  scenario "when visiting an individual category's page" do
    category = create(:category_with_jobs)
    job1, job2, job3, job4, job5 = category.jobs

    visit category_path(category)

    expect(page).to have_link(job1.title, href: job_path(job1))
    expect(page).to have_link(job2.title, href: job_path(job2))
    expect(page).to have_link(job3.title, href: job_path(job3))
    expect(page).to have_link(job4.title, href: job_path(job4))
    expect(page).to have_link(job5.title, href: job_path(job5))
  end
end