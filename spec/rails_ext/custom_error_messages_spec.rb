require File.dirname(__FILE__) + '/../spec_helper'
require 'active_project/rails_ext/custom_error_messages'


describe 'ActiveProject::RailsExt::CustomErrorMessages' do
    
    include ActiveProject::RailsExt::CustomErrorMessages
    
    before do
        @base = mock('Message', :column => 1 )
        Spec::Mocks::Mock.stub!(:human_attribute_name).and_return('human_attribute_name')
    end

    it 'should return normal error if err message does not start with ^' do
       @errors = { :column => 'is invalid' }

       full_messages_with_single_message.should == ['human_attribute_name is invalid']
    end

    it 'should return error message without table column when err message start with ^' do
        @errors = { :column => '^invalid column' }

        full_messages_with_single_message.should == ['invalid column']
    end

end
