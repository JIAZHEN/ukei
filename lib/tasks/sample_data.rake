namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    categories = ["Services", "Sectors", "Join us", "About us"].map do |name|
      Category.create!(name: name)
    end

    services = Category.find_by(name: "Services")
    [
      "Immigration", "Commercial Law", "Commercial Dispute Resolution", "Corporate",
      "Employment", "Family", "Real Estate"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(services)
    end

    sectors = Category.find_by(name: "Sectors")
    [
      "IT & Telecommunication", "Retail & E-commerce", "Real Estate", "Hotels & Restaurants",
      "Fashion", "Pharmaceuticals", "Healthcare",
      "Social Housing", "Education"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(sectors)
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
    ActiveRecord::Base.connection.exec_query("INSERT INTO casein_admin_users (id, login, name, email, access_level, crypted_password, password_salt, persistence_token, single_access_token, perishable_token, login_count, failed_login_count, last_request_at, current_login_at, last_login_at, current_login_ip, last_login_ip, time_zone, created_at, updated_at) VALUES (1, 'admin', 'Admin', 'sushilgaikwad@mac.com', 0, '400$8$16$881a100703d37241$545a0362ed619fe6bd01fb06f7b2e3fe004dc65f695adf389884bbcfa1bb7d19', 'JkezNR8LefdvMYRcxrK', '9321c84bf6ff2defc965a31f4f10092c2d4717e30c995d0e1a639fb5da074d2bd3cdf3e60a5fbf96ded21cea4403f90dc85c287e46e7ee406c8914a9a1052197', 'WyNLEzopFIH2vTrmu5Go', 'w6Czg9u6w6AkfCFx4rR', 0, 0, NULL, NULL, NULL, NULL, NULL, 'UTC', '2015-10-03 20:58:20', '2015-10-03 20:58:20');")
  end

  task :bootstrap => ["db:drop", "db:create", "db:migrate", "db:populate", "db:create_admin"]
end
