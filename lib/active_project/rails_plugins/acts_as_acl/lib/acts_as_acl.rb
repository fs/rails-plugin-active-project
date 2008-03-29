module Flatsoft
    module Plugins
        module Acts #:nodoc:
            module Acl

                def self.included(base) # :nodoc:
                    base.extend ClassMethods
                end
                
                module ClassMethods
                    def acts_as_acl(model_type)
                        if model_type == :account
                            include ActsMethods::Account
                        elsif model_type == :role
                            include ActsMethods::Role
                        elsif model_type == :relationship
                            include ActsMethods::Relationship
                        end
                    end
                end
                
                module ActsMethods
                    module Account
                        def self.included(account)
                            account.has_many :roles_relationships,
                                :class_name => 'AccountRoleRelationship',
                                :dependent  => :destroy
                            
                            # Account roles Should use roles.grant and
                            # roles.revoke for adding and removeing role from
                            # account
                            account.has_many :roles,
                                :through => :roles_relationships,
                                :uniq => true do
                                include Role::AccountClassMethods
                            end                            
                        end
                    end
                    
                    module Role
                        module AccountClassMethods
                            def self.included(roles)
                                @parent = roles
                            end
                            # Grant to the account role(s) by AccountRole
                            # instance @account.roles.grant(AccountRole.find(1),
                            # AccountRole.find(1))
                            def grant(*roles)
                                self << roles
                                reload
                            end
                            
                            # revoke some role(s) from account by AccountRole
                            # instance
                            # @account.roles.revoke(AccountRole.find(:first))
                            def revoke(*roles)
                                delete(roles)
                                reload
                            end
                            
                            # delete all roles from user
                            def delete_all
                                @reflection.through_reflection.klass.delete_all(@reflection.through_reflection.primary_key_name => @owner.id)
                                reload
                            end
                            alias_method :revoke_all, :delete_all
                        end
                        
                        def self.included(role)
                            role.validates_presence_of :title
                             
                            role.has_many :account_relationships,
                                :class_name => 'AccountRoleRelationship',
                                :dependent  => :destroy
                             
                            role.has_many :accounts,
                                :through => :account_relationships
                        end
                    end
                    
                    module Relationship
                        def self.included(relationship)
                            relationship.belongs_to :account
                            
                            relationship.belongs_to :role,
                                :class_name => 'AccountRole',
                                :foreign_key => 'account_role_id'
                            
                            relationship.validates_presence_of :account_id, :account_role_id                            
                        end
                    end
                end
            end
        end
    end
end