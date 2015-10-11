namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    categories = ["sectors", "services" "join us", "about us"].map do |name|
      Category.create!(name: name)
    end

    sectors = Category.find_by(name: "sectors")
    [
      "IT & Telecommunication", "retail and e-commerce", "real estate", "hotels and restaurants",
      "fashion", "pharmaceuticals", "health and care",
      "social housing", "education"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(sectors)
    end

    services = Category.find_by(name: "services")
    [
      "immigration", "commercial law", "commercial contract", "intellecture property",
      "commercial dispute resolution", "corporate", "employment", "family",
      "intellectual property", "it & telecommunication",
      "real estate", "regulatory compliance"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(services)
    end

    immigration = Category.find_by(name: "immigration")
    [
      "t1 entrepreneur migrants",
      "t1 investor migrants",
      "t2 intra – company transfer migrants",
      "t2 general", "t4 general student", "t4 child student", "t5 temporary worker",
      "marrage, civil partner, finance, unmarried partner visa",
      "indefinite leave to remain", "british citizenship"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(immigration)
    end

    PageContent.create!(name: "slogen", context: "We design services for customers that have impact on business")
    PageContent.create!(name: "home_intro", context: "Welcome. Over the last 14 years we have pioneered service design and made a difference for customers and organisations. We merge creativity, design and business to help organisations deliver a great customer experience and achieve tangible business results.")
    PageContent.create!(name: "logo")
  end

  task create_admin: :environment do
    `rake casein:users:create_admin email=jxie@example.com password=password`
  end

  task :bootstrap => ["db:drop", "db:create", "db:migrate", "db:populate", "db:create_admin"]
end
