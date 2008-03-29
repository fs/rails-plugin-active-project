module Flatsoft
    module Admin
        module Base
            def self.included(base)
                # defile layout
                base.layout 'admin/layouts/base'
                
                # setup nice error messages
                base.change_error_field_proc
                
                # add usefull helpers
                base.helper 'admin/menu', 'admin/list_table'
            end
        end
    end
end