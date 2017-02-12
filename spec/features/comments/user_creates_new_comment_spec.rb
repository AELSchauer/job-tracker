require 'rails_helper'
require 'faker'

RSpec.feature "User creates a comment" do
  let(:sentence) { Faker::Lorem.sentence(1) }
  let(:paragraph) { Faker::Lorem.paragraph(4) }
  let(:multi_paragraph) { Faker::Lorem.paragraphs(3).join("\r\n\r\n") }

  scenario "one sentence comment" do
    job = create(:job)
    visit job_path(job)

    click_on "Add Comment"

    expect(current_path).to eq("/jobs/#{job.id}/comments/new")
    fill_in "comment[content]", with: sentence
    click_on "Submit"

    expect(current_path).to eq("/jobs/#{job.id}")
    expect(find("div#comment-#{Comment.last.id}")).to have_content(sentence)
    expect(page).to have_content("Comment was successfully created!")
  end

  scenario "one paragraph comment" do
    job = create(:job)
    visit new_job_comment_path(job)

    fill_in "comment[content]", with: paragraph
    click_on "Submit"

    expect(find("div#comment-#{Comment.last.id}")).to have_content(paragraph)
  end

  scenario "multi-paragraph comment" do
    job = create(:job)
    visit new_job_comment_path(job)

    fill_in "comment[content]", with: paragraph
    click_on "Submit"

    expect(find("div#comment-#{Comment.last.id}")).to_not have_content(multi_paragraph)

    Comment.last.split_content.each do |comment_paragraph|
      expect(find("div#comment-#{Comment.last.id}")).to have_content(comment_paragraph)
    end
  end

  context "user submits an invalid form" do
    scenario "leaves 'content' blank" do
      job = create(:job)
      visit new_job_comment_path(job)

      click_on "Submit"

      expect(page).to have_content("Content can't be blank")
    end
  end
end