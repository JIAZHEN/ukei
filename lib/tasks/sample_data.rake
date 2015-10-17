namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    categories = ["Sectors", "Services", "Join us", "About us"].map do |name|
      Category.create!(name: name)
    end

    sectors = Category.find_by(name: "Sectors")
    [
      "IT & Telecommunication", "Retail & E-commerce", "Real Estate", "Hotels & Restaurants",
      "Fashion", "Pharmaceuticals", "Healthcare",
      "Social Housing", "Education"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(sectors)
    end

    services = Category.find_by(name: "Services")
    [
      "Immigration", "Commercial Law", "Commercial Contracts", "Sourcing", "Intellectual Property",
      "Commercial Dispute Resolution", "Corporate", "Mergers & Acquisitions", "Venture Capital & Private Equity",
      "Equity Capital Markets", "Employment", "Family", "IT & E-commerce",
      "Real Estate", "Regulatory Compliance"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(services)
    end

    immigration = Category.find_by(name: "Immigration")
    [
      "T1 Entrepreneur Migrants",
      "T1 Investor Migrants",
      "T2 Intra – Company Transfer Migrants",
      "T2 General", "T4 General Student", "T4 Child Student", "T5 Temporary Worker",
      "Marrage, Civil Partner, Finance, Unmarried Partner Visa",
      "Indefinite Leave To Remain", "British Citizenship"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(immigration)
    end

    PageContent.create!(name: "slogen", context: "We design services for customers that have impact on business")
    PageContent.create!(name: "home_intro", context: "Welcome. Over the last 14 years we have pioneered service design and made a difference for customers and organisations. We merge creativity, design and business to help organisations deliver a great customer experience and achieve tangible business results.")
    PageContent.create!(name: "logo")
  end

  task create_admin: :environment do
    ActiveRecord::Base.connection.exec_query("INSERT INTO casein_admin_users (id, login, name, email, access_level, crypted_password, password_salt, persistence_token, single_access_token, perishable_token, login_count, failed_login_count, last_request_at, current_login_at, last_login_at, current_login_ip, last_login_ip, time_zone, created_at, updated_at) VALUES (1, 'admin', 'Admin', 'jxie@example.com', 0, '400$8$15$5b51305d64d1dc51$5f0034d079642b2f8b2c1a68cee938d8b20852e9a94f9d72732af7e3b3c55e45', 'Do4OoTu8Z80t18cOo8P', '048401be9754f87c72d641e0505e6a3ca1042b6097f7f7ab8b425b68570fddd676169273dd8a372c868d857c6212eb920230f75b705ec5c43c53f6489f8ace32', 'G8gWw7ocEbLxvRjmmf', '3GGEZBm7flJ5OC0rtcPd', 0, 0, NULL, NULL, NULL, NULL, NULL, 'UTC', '2015-10-03 20:58:20', '2015-10-03 20:58:20');")
  end

  task :bootstrap => ["db:drop", "db:create", "db:migrate", "db:populate", "db:create_admin"]
end
