
if AdminUser.find_by(email: "admin@example.com").nil?
  AdminUser.create!(email: "admin@example.com", password: "testing123", password_confirmation: "testing123")
end

categories = %w[Fruit Apple Pear Watermelon Vegetables Cucumber Squash Onion]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end
