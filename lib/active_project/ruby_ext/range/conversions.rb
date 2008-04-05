module ActiveProject #:nodoc:
    module RubyExt #:nodoc:
        module Range # :nodoc:            
            module Conversions

                def self.included(klass) # :nodoc:
                    klass.send(:include, InstanceMethods)
                end
                
                module InstanceMethods
                
                    def to_dropdown
                        inject([]) { |array, item| array << [item, item] }
                    end
                
                end
            end
        end
    end
end

class Range
    include ActiveProject::RubyExt::Range::Conversions
end