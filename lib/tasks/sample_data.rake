namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "jiazhen",
                 email: "jxie@example.com",
                 password: "password",
                 password_confirmation: "password")

    categories = ["service", "about us", "join us", "partner", "contact us"].map do |name|
      Category.create!(name: name)
    end

    ["immigration law", "commercial law"].each do |name|
      Category.create!(name: name).move_to_child_of(categories[0])
    end

    ["our company", "our team"].each do |name|
      Category.create!(name: name).move_to_child_of(categories[1])
    end

  end
end
