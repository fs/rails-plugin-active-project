module ActiveProject #:nodoc:
    module RubyExt #:nodoc:
        module Hash # :nodoc:            
            module Conversions

                def self.included(klass) # :nodoc:
                    klass.send(:include, InstanceMethods)
                end
                
                module InstanceMethods
                
                    def to_dropdown
                        invert.sort { |a,b| a[1] <=> b[1] }
                    end
                
                end
            end
        end
    end
end

class Hash
    include ActiveProject::RubyExt::Hash::Conversions
end