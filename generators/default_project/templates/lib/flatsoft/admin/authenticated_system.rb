module Flatsoft
    module Admin
        module AuthenticatedSystem

            def self.included(base)
                base.before_filter :login_required
            end            
            
        end
    end
end