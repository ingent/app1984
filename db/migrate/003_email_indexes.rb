class EmailIndexes < ActiveRecord::Migration
  def self.up
    add_index :emails, "created_at"
    add_index :emails, "from"
  end

  def self.down
    remove_index :emails, "created_at"
    remove_index :emails, "from"
  end
end
