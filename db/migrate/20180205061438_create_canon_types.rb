class CreateCanonTypes < ActiveRecord::Migration
  def self.up
    create_table(:canon_types, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|

      t.column :name,                   :string
      t.column :relationship_operator,  :string

      t.column :wf_audit,               :integer,  { limit: 4, :default => 0 }
      t.column :wf_stage,               :integer,  { limit: 4, :default => 0 }
      t.column :wf_notes,               :string,  { limit: 255 }
      t.column :wf_owner,               :integer, { limit: 4, :default => 0 }
      t.column :wf_version,             :integer, { limit: 4, :default => 0 }

      t.column :created_at,             :datetime
      t.column :updated_at,             :datetime

      t.column :lock_version,           :integer, { limit: 4, :default => 0, :null => false }
    end

    add_index :canon_types, :name
    add_index :canon_types, :wf_stage

    execute "ALTER TABLE institutions AUTO_INCREMENT=#{RISM::BASE_NEW_IDS[:canon_types]}"

  end

  def self.down
    drop_table :canon_types
  end
end
