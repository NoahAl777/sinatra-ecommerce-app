#seed data to work with and test associations 

# Create 2 users

noah = User.create(name: "Noah", email: "noah@noah.com", password: "password")
lex = User.create(name: "Lex", email: "lex@lex.com", password: "password")

# Create some ecommerce entries

EcommerceEntry.create(title: "Make your car faster today!", price: 5000, content: "Turbo charger", user_id: noah.id)

# Use AR to pre-associate data:

noah.ecommerce_entries.create(title: "Get a new air filter now!", price: 75, content: "Best air filter on the market!")

lexs_entry = lex.ecommerce_entries.build(title: "Is your car having problems?", price: 0, content: "Free diagnostics at all of our locations!")
lexs_entry.save