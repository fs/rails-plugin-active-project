module Flatsoft
    module Admin
        module Base
            def self.included(base)
                # defile layout
                base.layout 'admin/layouts/base'
                
                # setup nice error messages
                base.change_error_field_proc
                
                # add usefull helpers
                base.helper ActiveProject::RailsExt::ActionPack::Helpers::Admin::Tab
                base.helper ActiveProject::RailsExt::ActionPack::Helpers::Admin::Menu
                base.helper ActiveProject::RailsExt::ActionPack::Helpers::Admin::ListTable
            end
        end
    end
end