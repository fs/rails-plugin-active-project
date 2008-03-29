class Admin::BaseController < ApplicationController

    include Flatsoft::Admin::Base
    include Flatsoft::Admin::AuthenticatedSystem
    include Flatsoft::Admin::RescueSystem        
	
end
