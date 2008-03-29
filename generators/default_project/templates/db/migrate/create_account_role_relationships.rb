class CreateAccountRoleRelationships < ActiveRecord::Migration
    def self.up
        create_table :account_role_relationships do |t|
            t.integer :account_id, :account_role_id
            t.timestamps
        end
    end

    def self.down
        drop_table :account_role_relationships
    end
end
