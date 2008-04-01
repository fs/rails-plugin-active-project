module ActiveProject #:nodoc:
    module RailsExt #:nodoc:
        module ActionPack #:nodoc:
            module Helpers #:nodoc:
                module Admin #:nodoc:
                    module ListTable
                        def list_table_title
                            render :partial => 'admin/shared/list_table_title'
                        end
                    end                
                end
            end
        end
    end
end