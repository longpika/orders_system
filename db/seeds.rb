# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

list_user_info = [
  {name: 'Peter Parker', email: 'spider_man@gmail.com', is_admin: true, password: '123456'},
  {name: 'Tony Stark', email: 'iron_man@gmail.com', password: '123456'},
  {name: 'Thor', email: 'thunder_god@gmail.com', password: '123456'},
  {name: 'Loki', email: 'liar_and_weakness_god@gmail.com', password: '123456'},
  {name: 'May', email: 'spider_man_aunt@gmail.com', password: '123456'},
  {name: 'Rocket Raccoon', email: 'guardian_of_galaxy_raccoon@gmail.com', password: '123456'},
  {name: 'Scot Lang', email: 'ant_man@gmail.com', password: '123456'}
]

list_user_info.each do |user|
  User.create(user)
end

list_product_info = [
  { name: 'Spider man figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Iron man figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Hulk figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Loki figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Thor figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Rocket Raccoon figure', amount: rand(50..100).to_f, quantity: rand(50..1000) },
  { name: 'Ant man figure', amount: rand(50..100).to_f, quantity: rand(50..1000) }
]

list_product_info.each do |product|
  Product.create(product)
end

product_ids = Product.all.pluck(:id)
user_ids = User.all.pluck(:id)

for i in 1 .. 50 do
  item_number = rand(1..5)
  order = Order.create(user_id: user_ids.sample, status: rand(0..3))
  total = order.total.to_f
  for j in 1..item_number do
    product = Product.find_by(id: product_ids.sample)
    quantity = rand(1..10)
    order_items = order.order_items
    item = order_items.find_by(product_id: product.id)
    if item
      item.update(quantity: item.quantity + quantity)
    else
      order_items.create(product_id: product.id, quantity: quantity)
    end
    product.update(quantity: product.quantity - (item ? item.quantity : quantity))
    total += quantity * product.amount
  end
  order.update(total: total)
end