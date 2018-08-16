class CreateContactPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_phones do |t|
      t.string :name
      t.string :phone
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
