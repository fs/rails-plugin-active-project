require File.dirname(__FILE__) + '/../../spec_helper'

require 'active_project/ruby_ext/array/conversions'

describe 'Array#to_dropdown' do
    
    before do
        @arr1 = [ 
            mock('Item', :name => 'foo', :id => 1),
            mock('Item', :name => 'bar', :id => 2),
            mock('Item', :name => 'baz', :id => 3)
        ]

        @arr2 = [ 
            mock('Item', :text => 'foo', :value => 1),
            mock('Item', :text => 'bar', :value => 2),
            mock('Item', :text => 'baz', :value => 3)
        ]
    end

    it 'returns an options array of names and ids usinig default key and value' do
        @arr1.to_dropdown.should == [["foo", 1], ["bar", 2], ["baz", 3]]
    end  
    
    it 'returns an options array of names and ids usinig custom key and value' do
        @arr2.to_dropdown(:text, :value).should == [["foo", 1], ["bar", 2], ["baz", 3]]
    end
    
end
