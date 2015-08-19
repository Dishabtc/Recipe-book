# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless Category.all.count == 4
  categories = Category.create([{ name: 'Italian Food Recipes' }, 
    { name: 'Punjabi Food Recipes' }, 
    { name: 'Gujarati Food Recipes' }, { name: 'Soup Recipes' }])
end

unless Role.all.count == 3

# role = Role.create([{ name: 'Member' },{ name: 'Admin' }, { name: 'Manager' } ])
  ['Member', 'Admin', 'Manager',].each do |role|
    Role.find_or_create_by({name: role})
  end
end

unless User.find_by_email('ozadisha470@gmail.com').present?

  User.create!({
               email: "ozadisha470@gmail.com",
               password: "12345678",
               password_confirmation: "12345678",
               admin: true
               })
end
         
             


# 1.upto(4) do |i|
#    Category.create(:name => "Category #{i}")
# end