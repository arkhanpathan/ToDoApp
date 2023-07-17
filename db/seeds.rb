# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Moviadmin@admin.come.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
  User.create(first_name: 'Admin', last_name: '', email: '', password: 'Admin@123', password_confirmation: 'Admin@123', is_admin: true)