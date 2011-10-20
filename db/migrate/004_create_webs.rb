class CreateWebs < ActiveRecord::Migration
  def self.up
    create_table :webs do |t|
      t.column :dia,        :integer
      t.column :ip,         :string
      t.column :domain,     :string
      t.column :hora_inici, :string
      t.column :hora_fi,    :string
      t.column :bytes,      :integer
      t.column :contador,   :integer

      t.column :updated_at, :datetime
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :webs
  end
end

