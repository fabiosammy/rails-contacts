class Contact < ApplicationRecord
  enum gender: [:male, :female]
  validates_presence_of :name, :gender
  validates_presence_of :salary, if: :employed?
  validates_uniqueness_of :name
end
