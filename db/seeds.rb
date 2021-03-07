#seed data to work with and test associations 

# Create 2 users

noah = User.create(name: "Noah", email: "noah@noah.com", password: "password")
lex = User.create(name: "Lex", email: "lex@lex.com", password: "password")

# Create some ecommerce entries

EcommerceEntry.create(content: "Turbo charger", user_id: noah.id)

# Use AR to pre-associate data:

noah.ecommerce_entries.create(content: "We are building a Sinatra App!")

lexs_entry = lex.ecommerce_entries.build(content: "I like this app!")
lexs_entry.save