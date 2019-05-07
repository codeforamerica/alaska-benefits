class AddAddressToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :name, :string
    add_column :clients, :street_address, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :zip_code, :string
  end
end
