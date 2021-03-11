class User < ActiveRecord::Base
  has_secure_password

  # Prevent creating, saving, or updating if these req. are not met
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  
  has_many :ecommerce_entries
  
end