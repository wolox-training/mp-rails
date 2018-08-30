class AddDeviseTokenAuthFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, null: false, default: 'email'
    add_column :users, :uid, :string, null: false, default: ''
    add_column :users, :allow_password_change, :boolean, default: false
    add_column :users, :tokens, :json
    # index
    add_index :users, %i[uid provider], unique: true
  end
end
