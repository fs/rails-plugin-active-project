Dir[File.join(File.dirname(__FILE__), 'rails_plugins', '**', 'init.rb')].each { |file| require(file) }