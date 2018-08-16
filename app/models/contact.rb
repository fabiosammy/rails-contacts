class Contact < ApplicationRecord
  enum gender: [:male, :female]
  has_many :phones, class_name: 'Contact::Phone'
  validates_presence_of :name, :gender
  validates_presence_of :salary, if: :employed?
  validates_uniqueness_of :name
end

# module Contact
#   def self.table_name_prefix
#     'contact_'
#   end
# end
