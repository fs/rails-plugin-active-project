class AccountRole < ActiveRecord::Base

    acts_as_acl :role

end 


