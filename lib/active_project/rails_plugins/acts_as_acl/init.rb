require File.join(File.dirname(__FILE__), 'lib', 'acts_as_acl')

ActiveRecord::Base.send :include, Flatsoft::Plugins::Acts::Acl