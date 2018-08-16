class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :birthday
      t.boolean :employed
      t.decimal :salary
      t.integer :gender

      t.timestamps
    end
  end
end
