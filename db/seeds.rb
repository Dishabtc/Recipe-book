# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ name: 'Italian food recipes' }, 
  { name: 'punjabi food recipes' }, 
  { name: 'Gujarati food recipes' }, { name: 'Soup recipes' }])

# 1.upto(4) do |i|
#    Category.create(:name => "Category #{i}")
# end