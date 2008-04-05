require File.dirname(__FILE__) + '/../../spec_helper'

require 'active_project/ruby_ext/range/conversions'

describe 'Range#to_dropdown' do
    
    before do
        @range = 2008..2010
    end

    it 'returns an options array of names and ids' do
        @range.to_dropdown.should == [[2008, 2008], [2009, 2009], [2010, 2010]]
    end  
    
end
