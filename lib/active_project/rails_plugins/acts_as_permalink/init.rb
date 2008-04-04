require File.join(File.dirname(__FILE__), 'lib', 'acts_as_permalink')

ActiveRecord::Base.send :include, Flatsoft::Plugins::Acts::Permalink