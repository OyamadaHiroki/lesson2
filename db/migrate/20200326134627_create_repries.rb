class CreateRepries < ActiveRecord::Migration[6.0]
  def change
    create_table :repries do |t|
      t.references :post, null: false, foreign_key: true
      t.string :user_id
      t.text :repry, null: false 

      t.timestamps
    end
  end
end
