namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    categories = ["sectors", "services", "china desk", "join us", "partner", "about us"].map do |name|
      Category.create!(name: name)
    end

    sectors = Category.find_by(name: "sectors")
    [
      "it", "retail and e-commerce", "real estate", "hotels and restaurants",
      "fashion", "pharmaceuticals", "health and care",
      "social housing", "education"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(sectors)
    end

    services = Category.find_by(name: "services")
    [
      "immigration", "business law", "commercial", "commercial property",
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

  end

  task :bootstrap => ["db:drop", "db:create", "db:migrate", "db:populate"]
end
