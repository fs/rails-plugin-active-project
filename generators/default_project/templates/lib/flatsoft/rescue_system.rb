module Flatsoft
    module RescueSystem

        def self.included(base)
            base.send(:include, InstanceMethods)

            base.rescue_from(
                ActiveRecord::RecordNotFound,
                ActionController::UnknownController,
                ActionController::UnknownAction,
                ActionController::RoutingError,
                ActionController::MethodNotAllowed,
                ActionController::MissingFile,
                :with => :render_404
            )
            
            base.rescue_from(
                Flatsoft::AclSystem::PermissionDenied,
                Flatsoft::AuthenticatedSystem::AccessDenied,
                :with => :access_denied
            )
        end
        
        module InstanceMethods
            protected

            # Render frandly page with 404 error message
            def render_404
                render :template => 'errors/404'
            end
            
            # Redirect as appropriate when an access request fails.
            # 
            # The default action is to redirect to the login screen.
            # 
            # Override this method in your controllers if you want to have special
            # behavior in case the user is not authorized to access the requested
            # action.  For example, a popup window might simply close itself.
            def access_denied
                respond_to do |format|
                    format.html do
                        store_location
                        redirect_to new_session_path
                    end
                    format.xml do
                        request_http_basic_authentication 'Web Password'
                    end
                    format.js do
                        store_location
                        render(:update) { |page| page.redirect_to new_session_path }
                    end
                end
            end
        end        
    end
end