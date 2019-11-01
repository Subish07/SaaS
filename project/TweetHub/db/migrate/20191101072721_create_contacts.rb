class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :feedback

      t.timestamps
    end
  end
end
