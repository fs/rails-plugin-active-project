require File.dirname(__FILE__) + '/../../spec_helper'

require 'active_project/ruby_ext/yaml'

describe 'ActiveProject::RubyExt::YAML::Config' do
    
    before do
        @config = YAML.load_config(File.dirname(__FILE__) + '/../../fixtures/config.yml')
    end
    
    it 'should load YAML properly' do
        @config['string'].should == 'string'
    end
    
    it 'should eval erb' do
        @config['erb'].should == 2
    end
end
