class Reports < ActiveRecord::Migration
  def self.up
    create_table "reports" do |t|
      t.column "body", :text
      t.column "from", :datetime
      t.column "to", :datetime
      t.column "order", :string
      t.column "created_at", :datetime
    end
  end
  def self.down
    drop_table "reports"
  end
end
