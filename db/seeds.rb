require 'faker'

Company.destroy_all
Job.destroy_all
Category.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "Denver Public Schools", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
JOBS = [ "Statistician", "Business Analyst", "Writer", "Accountant", "Architect", "Designer", "Interpreter", "Librarian" "Engineer", "Developer", "Dev Ops", "Quality Assurance", "Teacher", "Product Manager", "Consultant", "Community Manager"]
CITIES = ["Seattle", "Denver", "Portland", "Indianapolis", "Madison", "Orlando", "San Diego", "Austin", "Las Vegas", "Little Rock", "Boise", "Eugene", "Oakland"]

10.times do
  Category.create(title: Faker::Book.genre)
end

job_hash = {}
COMPANIES.each do |name|
  company = Company.create(name: name)
  puts "Created #{company.name}"
  10.times do |num|
    title = JOBS.sample
    job_hash[title].nil? ? job_hash[title] = 1 : job_hash[title] += 1
    description = Faker::Lorem.paragraphs(3).join("\r\n\r\n")
    company.jobs.create!(title: "#{title} #{job_hash[title]}", description: description, level_of_interest: num + rand(100), city: CITIES.sample, category_id: Category.pluck(:id).sample)
    puts "  Created #{company.jobs[num].title}"
  end
end
