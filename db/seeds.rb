# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(email: "neener@neener.nyc", password: "therealzoocat")
User.create(email: "peterpiper@beanstalks.com", password: "greenbeans")
User.create(email: "jacknjill@twins.com", password: "twinsies")

Category.delete_all
Category.create(name: "beauty", user_id: 4)
Category.create(name: "ugliness", user_id: 4)
Category.create(name: "pigs", user_id: 4)

Category.create(name: "nails", user_id: 5)
Category.create(name: "toes", user_id: 5)
Category.create(name: "romance", user_id: 5)

Category.create(name: "computers", user_id: 3)
Category.create(name: "cyborgs", user_id: 3)
Category.create(name: "happiness", user_id: 3)

Comment.delete_all
Comment.create(text: "bkldsjafkldjksla", category_id:1)
Comment.create(text: "popopopopop", category_id:2)
Comment.create(text: "fdsjaklfkjewlk", category_id:3)

