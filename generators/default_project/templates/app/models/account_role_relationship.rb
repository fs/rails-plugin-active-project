class AccountRoleRelationship < ActiveRecord::Base

    acts_as_acl :relationship
    
end
