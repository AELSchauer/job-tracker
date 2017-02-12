require 'faker'

Company.destroy_all
Job.destroy_all
Category.destroy_all
Contact.destroy_all
Comment.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "YNAB", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
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

Job.all.each do |job|
  num = rand(1..3)
  num.times do
    comment_options = [
      Faker::Lorem.paragraphs(rand(2..3)).join("\r\n\r\n"),
      Faker::Lorem.sentences(3).join(" "),
      Faker::Lorem.sentences(2).join(" "),
      Faker::Lorem.sentences(1).join(" ")
    ]
    job.comments.create(content: comment_options.sample)
  end
end

position_hash = {}
Company.all.each do |company|
  num = rand(1..3)
  joiner = [".","-","_",""].sample
  num.times do
    position = Faker::Job.title
    position_hash[position].nil? ? position_hash[position] = 1 : position_hash[position] += 1
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "#{[first_name.downcase, last_name.downcase].join(joiner)}@#{company.name.downcase}.com"
    company.contacts.create(first_name: first_name, last_name: last_name, position: "#{position} #{position_hash[position]}", email: email)
  end
end

