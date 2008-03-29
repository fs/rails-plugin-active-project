require File.dirname(__FILE__) + '/../../spec_helper'

require 'active_project/ruby_ext/class'

class ClassWithPrivateAndProtectedMethods
    private
        def private_method
            "I'm private"
        end

    protected        
        def protected_method
            "I'm protected"
        end
end

describe 'ActiveProject::RubyExt::Class::PublicizeMethods' do

    before do
        @klass = ClassWithPrivateAndProtectedMethods.new()
        @private_call = lambda { @klass.private_method }
        @protected_call = lambda { @klass.protected_method }

    end

    it 'should raise error when calling private method' do
        @private_call.should raise_error(NoMethodError)
    end
 
    it 'should raise error when calling protected method' do
        @protected_call.should raise_error(NoMethodError)
    end

    it 'should not raise error after publicize methods when calling private method' do
        ClassWithPrivateAndProtectedMethods.publicize_methods do
            @private_call.should_not raise_error(NoMethodError)
            @private_call.call.should == "I'm private"
        end
    end

    it 'should not raise error after publicize methods when calling protected method' do
        ClassWithPrivateAndProtectedMethods.publicize_methods do
            @protected_call.should_not raise_error(NoMethodError)
            @protected_call.call.should == "I'm protected"
        end
    end

end
