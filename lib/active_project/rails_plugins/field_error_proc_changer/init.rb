require File.join(File.dirname(__FILE__), 'lib', 'change_error_field_proc')

class ActionController::Base
    include Flatsoft::Plugins::ChangeErrorFieldProc
end