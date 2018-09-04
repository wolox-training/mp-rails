class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.belongs_to :book, foreign_key: true, null: false
      t.belongs_to :user, foreign_key: true,  null: false
      t.datetime :from, :to, null: false
      t.timestamps
    end
  end
end
