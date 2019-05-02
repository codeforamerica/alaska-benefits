class AddDefaultToOptIns < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :text_opt_in, :boolean, default: false
    change_column :clients, :email_opt_in, :boolean, default: false
  end
end
