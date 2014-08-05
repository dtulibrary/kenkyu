class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table :users do |t|
      t.string  :username,   :null => false
      t.string  :first_name
      t.string  :last_name
      t.string  :email

      t.timestamps
    end

    add_index :users, :username
  end

  def self.down
  end

end
