class CreateAccounts < ActiveRecord::Migration
    def self.up
        create_table "accounts", :force => true do |t|
            t.string :login, :email, :remember_token
            t.string :crypted_password, :salt, :limit => 40
            t.string :state, :null => :no
            t.datetime :remember_token_expires_at, :deleted_at
            t.timestamps
        end
    end

    def self.down
        drop_table :accounts
    end
end
