class ApplicationController < ActionController::Base
    
    include Flatsoft::Base
    include Flatsoft::AuthenticatedSystem
    include Flatsoft::AclSystem
    include Flatsoft::RescueSystem    

end