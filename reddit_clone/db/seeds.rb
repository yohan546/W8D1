# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Sub.delete_all
Post.delete_all

dave = User.create(username: 'dave', password: '1234')
rich = User.create(username: 'rich', password: '124')

new_sub = Sub.create(title: 'Help', description: 'we stuck', moderator: dave.id)

post = Post.create(title: 'here to help', content: 'jk', sub_id: new_sub.id, author_id: rich.id)