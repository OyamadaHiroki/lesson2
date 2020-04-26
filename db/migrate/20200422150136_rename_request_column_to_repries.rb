class RenameRequestColumnToRepries < ActiveRecord::Migration[6.0]
  def change
    rename_column :repries, :repry, :content
  end
end
