# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  puts "Seeding..."
  #rest
  desi_rest = Restaurant.create({restaurant_name: 'Desi Restaurant'})
  it_rest = Restaurant.create({restaurant_name: 'Italian Restaurant'})
  ff_rest = Restaurant.create({restaurant_name: 'Fast Food Restaurant'})

  #cat
  sp_cat = Category.create({category_name: 'Spicy'})
  sm_cat = Category.create({category_name: 'Small plates'})
  ff_cat = Category.create({category_name: 'Fast food'})
  sw_cat = Category.create({category_name: 'Sweet'})
  bg_cat = Category.create({category_name: 'Big size'})

  cat_ids = Category.all.pluck(:id)
  rest_ids = Restaurant.all.pluck(:id)
  #items
  bir_item = Item.create({item_title: "Biryani", item_description: "Masala rice with meat", item_price: 250, is_sold: true,
  restaurant_id: desi_rest.id})
  kar_item = Item.create({item_title: "Karahi", item_description: "Savoury meat curry", item_price: 450, is_sold: true,
  restaurant_id: desi_rest.id})
  pul_item = Item.create({item_title: "Pulao", item_description: "Stew rice with meat", item_price: 250, is_sold: true,
  restaurant_id: desi_rest.id})
  qor_item = Item.create({item_title: "Qourma", item_description: "Spicy masala curry meat", item_price: 350, is_sold: true,
  restaurant_id: desi_rest.id})

  spa_item = Item.create({item_title: "Spaghetti", item_description: "Noodles with meat balls", item_price: 300, is_sold: true,
  restaurant_id: it_rest.id})
  pas_item = Item.create({item_title: "Pasta", item_description: "Simple handmade pasta", item_price: 250, is_sold: true,
  restaurant_id: it_rest.id})
  ter_item = Item.create({item_title: "Terramizu", item_description: "Sweet creamy dessert", item_price: 410, is_sold: true,
  restaurant_id: it_rest.id})

  bef_item = Item.create({item_title: "Beef Burger", item_description: "Cheesy burger with beef patty", item_price: 400, is_sold: true,
  restaurant_id: ff_rest.id})
  piz_item = Item.create({item_title: "Pizza", item_description: "Chicken fajita pizza", item_price: 720, is_sold: true,
  restaurant_id: ff_rest.id})
  chi_item = Item.create({item_title: "Chicken wings", item_description: "Spicy chicken wings with BBQ sauce", item_price: 550, is_sold: true,
  restaurant_id: ff_rest.id})

  #CAT/ITEM
  CategoryItem.create({item_id: bir_item.id, category_id: sp_cat.id})
  CategoryItem.create({item_id: bir_item.id, category_id: sm_cat.id})
  CategoryItem.create({item_id: qor_item.id, category_id: sp_cat.id})
  CategoryItem.create({item_id: qor_item.id, category_id: bg_cat.id})
  CategoryItem.create({item_id: pul_item.id, category_id: sm_cat.id})
  CategoryItem.create({item_id: kar_item.id, category_id: sp_cat.id})
  CategoryItem.create({item_id: spa_item.id, category_id: sp_cat.id})
  CategoryItem.create({item_id: pas_item.id, category_id: sm_cat.id})
  CategoryItem.create({item_id: piz_item.id, category_id: ff_cat.id})
  CategoryItem.create({item_id: bef_item.id, category_id: ff_cat.id})
  CategoryItem.create({item_id: chi_item.id, category_id: ff_cat.id})
  CategoryItem.create({item_id: chi_item.id, category_id: bg_cat.id})
  CategoryItem.create({item_id: chi_item.id, category_id: sp_cat.id})
  CategoryItem.create({item_id: ter_item.id, category_id: sw_cat.id})

  #User
  rachel = User.create({first_name: "Rachel", last_name: "Warbelow", email: "demo+rachel@jumpstartlab.com",password: "password"})

  jorge = User.create({first_name: "Jorge", last_name: "Tellez", email: "demo+jorge@jumpstartlab.com",password: "password",
  display_name: "novohispano"})

  jeff = User.create({first_name: "Jeff", last_name: "Casimir", email: "demo+jeff@jumpstartlab.com", password: "password",
  display_name: "j3"})

  #admin:
  admin = User.create({first_name: "Josh", last_name: "Cheek", email: "demo+josh@jumpstartlab.com", password: "password",
  display_name: "josh", is_admin: true})


  #ORDERS
  rach_o1 = Order.create({user_id: rachel.id, status: 0, total: 500})
  OrderItem.create({order_id: rach_o1.id, item_id: bir_item.id, quantity: 2})

  rach_o2 = Order.create({user_id: rachel.id, status: 0, total: 450})
  OrderItem.create({order_id: rach_o2.id, item_id: kar_item.id, quantity: 1})

  rach_o3 = Order.create({user_id: rachel.id, status: 3, total: 1230})
  OrderItem.create({order_id: rach_o3.id, item_id: ter_item.id, quantity: 3})

  rach_o4 = Order.create({user_id: rachel.id, status: 3, total: 720})
  OrderItem.create({order_id: rach_o4.id, item_id: piz_item.id, quantity: 1})

  #Jeff
  jeff_o1 = Order.create({user_id: jeff.id, status: 2, total: 1000})
  OrderItem.create({order_id: jeff_o1.id, item_id: bir_item.id, quantity: 4})

  jeff_o2 = Order.create({user_id: jeff.id, status: 2, total: 500})
  OrderItem.create({order_id: jeff_o2.id, item_id: pul_item.id, quantity: 2})

  jeff_o3 = Order.create({user_id: jeff.id, status: 2, total: 900})
  OrderItem.create({order_id: jeff_o3.id, item_id: spa_item.id, quantity: 3})

  #jorge
  jorge_o1 = Order.create({user_id: jorge.id, status: 1, total: 800})
  OrderItem.create({order_id: jorge_o1.id, item_id: bef_item.id, quantity: 2})

  jorge_o2 = Order.create({user_id: jorge.id, status: 1, total: 250})
  OrderItem.create({order_id: jorge_o2.id, item_id: pas_item.id, quantity: 1})

  jorge_o3 = Order.create({user_id: jorge.id, status: 0, total: 550})
  OrderItem.create({order_id: jorge_o3.id, item_id: chi_item.id, quantity: 1})

  puts "Seeding done!"







  # User.delete({email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123', name: 'admin', display_name: 'admind'})
  #User.create({email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123', first_name: 'admin', last_name: 'bhai', display_name: 'admind', is_admin: true})
