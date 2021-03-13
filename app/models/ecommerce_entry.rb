class EcommerceEntry < ActiveRecord::Base

  belongs_to :user
  
   # Prevent creating, saving, or updating if these req. are not met
   validates :title, presence: true
   validates :price, presence: true
   validates :content, presence: true

end
