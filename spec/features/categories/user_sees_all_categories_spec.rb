require "rails_helper"

RSpec.feature "User sees a list of all categories" do
  scenario "when visiting the category index page" do
    category1, category2, category3, category4 = create_list(:category, 4)

    visit categories_path

    cat1 = page.find("#category-#{category1.id}")
    expect(cat1).to have_link(category1.title, href: category_path(category1))
    expect(cat1).to have_link("Edit", href: edit_category_path(category1))

    cat2 = page.find("#category-#{category2.id}")
    expect(cat2).to have_link(category2.title, href: category_path(category2))
    expect(cat2).to have_link("Edit", href: edit_category_path(category2))

    cat3 = page.find("#category-#{category3.id}")
    expect(cat3).to have_link(category3.title, href: category_path(category3))
    expect(cat3).to have_link("Edit", href: edit_category_path(category3))

    cat4 = page.find("#category-#{category4.id}")
    expect(cat4).to have_link(category4.title, href: category_path(category4))
    expect(cat4).to have_link("Edit", href: edit_category_path(category4))

  end
end