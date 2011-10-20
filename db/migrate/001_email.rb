class Email < ActiveRecord::Migration
  def self.up
    create_table "emails" do |t|
      t.column "from", :string
      t.column "to", :string
      t.column "subject", :string
      t.column "body", :string
      t.column "attachments", :string
      t.column "bytes", :integer
      t.column "spam", :boolean
      t.column "spam_score", :integer
      t.column "created_at", :datetime
    end
  end
  def self.down
    drop_table "emails"
  end
end
