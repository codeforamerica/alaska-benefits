class AddMailedToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :mailed, :bool, default: false
  end
end
