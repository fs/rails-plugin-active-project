module Flatsoft
    module Admin
        module RescueSystem
            
            def self.included(base)
                base.send(:include, InstanceMethods)

                base.rescue_from(
                    Flatsoft::AclSystem::PermissionDenied,
                    Flatsoft::AuthenticatedSystem::AccessDenied,
                    :with => :access_denied
                )
            end
        
            module InstanceMethods
                protected
   
                def access_denied
                    respond_to do |format|
                        format.html do
                            store_location
                            redirect_to new_admin_session_path
                        end
                        format.xml do
                            request_http_basic_authentication 'Web Password'
                        end
                        format.js do
                            store_location
                            render(:update) { |page| page.redirect_to new_admin_session_path }
                        end
                    end
                end
            
            end        
        end
    end
end