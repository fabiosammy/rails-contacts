class AddGeographicLocationInContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :latitude, :decimal
    add_column :contacts, :longitude, :decimal
    add_column :contacts, :altitude, :decimal
  end
end
