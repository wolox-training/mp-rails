class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :genre, :author, :image, :title, :publisher, :year, null: false
      t.timestamps
    end
  end
end
