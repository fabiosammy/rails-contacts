class Contact::Phone < ApplicationRecord
  belongs_to :contact, class_name: 'Contact'
  validates_presence_of :name, :phone, :contact
  validates_uniqueness_of :phone, scope: :contact
end
