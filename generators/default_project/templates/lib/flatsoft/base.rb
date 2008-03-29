module Flatsoft
    module Base
        def self.included(base)
            # defile layout
            base.layout 'layouts/base'
            
            base.protect_from_forgery
        end
    end
end