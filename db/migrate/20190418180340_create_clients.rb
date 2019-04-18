class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :phone
      t.boolean :text_opt_in
      t.string :email
      t.boolean :email_opt_in
      t.string :office_choice

      t.timestamps
    end
  end
end
