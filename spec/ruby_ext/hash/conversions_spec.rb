require File.dirname(__FILE__) + '/../../spec_helper'

require 'active_project/ruby_ext/hash/conversions'

describe 'Hash#to_dropdown' do
    
    before do
        @hash = {
            1   => 'foo',
            2   => 'bar',
            3   => 'baz'
        }
    end

    it 'returns an options array of names and ids' do
        @hash.to_dropdown.should == [["foo", 1], ["bar", 2], ["baz", 3]]
    end  
    
end
