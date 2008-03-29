require File.dirname(__FILE__) + '/../../spec_helper'

require 'action_controller'
require 'active_project/ruby_ext/dir'

describe 'ActiveProject::RubyExt::Dir::RequireEach' do
    before do
       @do_require = lambda { Dir.require_each('test_lib') }
    end
    
    it 'should not raise error' do
        @do_require.should_not raise_error
    end
    
    it 'should require test LibOne and LibTwo' do
        @do_require.call
        
        defined?(LibOne).should == 'constant'
        defined?(LibTwo).should == 'constant'
    end
end