begin
    require_library_or_gem "redcloth" unless Object.const_defined?(:RedCloth)
    require File.join(File.dirname(__FILE__), 'lib', 'textilize_fu')
    ActiveRecord::Base.send :include, Flatsoft::Plugins::TextilizeFu
rescue LoadError
end