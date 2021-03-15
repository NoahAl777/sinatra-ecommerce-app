#seed data to work with and test associations 

# Create 2 users

mark = User.create(name: "Mark", email: "mark@mark.com", password: "password")
jess = User.create(name: "Jess", email: "jess@jess.com", password: "password")

# Create some ecommerce entries

EcommerceEntry.create(title: "Make your car faster today!", price: 5000, content: "Turbo charger", user_id: mark.id)

# Use AR to pre-associate data:

mark.ecommerce_entries.create(title: "Get a new air filter now!", price: 75, content: "Best air filter on the market!")

jess_entry = jess.ecommerce_entries.build(title: "Is your car having problems?", price: 0, content: "Free diagnostics at all of our locations!")
jess_entry.save