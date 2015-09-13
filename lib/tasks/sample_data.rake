namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "jiazhen",
                 email: "jxie@example.com",
                 password: "password",
                 password_confirmation: "password")

  end
end
