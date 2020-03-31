class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name,null: false
      t.string :image
      t.text :profile
      t.string :email
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :email, unique:true
  end
end
