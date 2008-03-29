class CreateAccountRoles < ActiveRecord::Migration
    def self.up
        create_table :account_roles do |t|
            t.string :title
            t.timestamps
        end
    end

    def self.down
        drop_table :account_roles
    end
end
