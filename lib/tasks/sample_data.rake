namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    categories = ["Sectors", "Services", "Join us", "About us"].map do |name|
      Category.create!(name: name)
    end

    sectors = Category.find_by(name: "Sectors")
    [
      "IT and Telecommunication", "Retail and E-commerce", "Real Estate", "Hotels and Restaurants",
      "Fashion", "Pharmaceuticals", "Healthcare",
      "Social Housing", "Education"
    ].each do |name|
      Category.create!(name: name).move_to_child_of(sectors)
    end

    services = Category.find_by(name: "Services")
    [
      "Immigration", "Business Law", "Commercial", "Commercial Property",
      "Commercial Dispute Resolution", "Corporate", "Employment", "Family",
      "Intellectual Property", "IT and Telecommunication",
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

    PageContent.create!(name: "slogen", context: "Keep calm and we are here")
    PageContent.create!(name: "home_intro", context: "RSB Solicitors is a London-based firm with a team of hugely experienced and professional advisers to help you deal with virtually any legal or business matter.

Among the services we offer are legal guidance and advice when dealing with business law, property acquisition and management, immigration, intellectual property, and accounting. We are also experts in helping non-resident Indians with a vast array of different objectives here in the UK.

We understand that when you seek advice on a legal or business matter, you are looking for a company which will provide you with accurate information, as well as affordable and intelligent solutions to your problems. At RSB we do just that. Your personal and business needs are at the forefront of our minds, and we take pride in assisting you efficiently and professionally.

Being based in London, we feel we are at the heart of the UK's business world, and are well situated to both advise you, and provide finance and accounting solutions.

If you would like to talk to one of our advisers about anything at all, please contact us today via telephone or e-mail and we will respond to your query as quickly as possible.")
    PageContent.create!(name: "logo")
  end

  task create_admin: :environment do
    ActiveRecord::Base.connection.exec_query("INSERT INTO casein_admin_users (id, login, name, email, access_level, crypted_password, password_salt, persistence_token, single_access_token, perishable_token, login_count, failed_login_count, last_request_at, current_login_at, last_login_at, current_login_ip, last_login_ip, time_zone, created_at, updated_at) VALUES (1, 'admin', 'Admin', 'sushilgaikwad@mac.com', 0, '400$8$16$881a100703d37241$545a0362ed619fe6bd01fb06f7b2e3fe004dc65f695adf389884bbcfa1bb7d19', 'JkezNR8LefdvMYRcxrK', '9321c84bf6ff2defc965a31f4f10092c2d4717e30c995d0e1a639fb5da074d2bd3cdf3e60a5fbf96ded21cea4403f90dc85c287e46e7ee406c8914a9a1052197', 'WyNLEzopFIH2vTrmu5Go', 'w6Czg9u6w6AkfCFx4rR', 0, 0, NULL, NULL, NULL, NULL, NULL, 'UTC', '2015-10-03 20:58:20', '2015-10-03 20:58:20');")
  end

  task :bootstrap => ["db:drop", "db:create", "db:migrate", "db:populate", "db:create_admin"]
end
