class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index(:webs,:dia)
    add_index(:webs,:ip)
    add_index(:webs,:domain)
  end

  def self.down
    remove_index(:webs,:dia)
    remove_index(:webs,:ip)
    remove_index(:webs,:domain)
  end
end
