require File.join(File.dirname(__FILE__), 'error_field_proc_changer')

module Flatsoft
    module Plugins
        module ChangeErrorFieldProc

            def self.included(base) # :nodoc:
                base.extend(ClassMethods)
            end
            
            module ClassMethods
                DEFAULT_PROC = Proc.new do |html_tag, instance|
                    if html_tag =~ /<label/   
                        html_tag
                    else
                        error = instance.error_message.kind_of?(Array) ? instance.error_message.join(', ') : instance.error_message
                        %(<div class="field-with-errors">#{html_tag}</div><span class="field-error">&nbsp;#{error}</span>)
                    end
                end
                
                
                def change_error_field_proc(*args)
                    args = [args] unless args.is_a?(Array)
                    conditions = args.extract_options!
                    
                    around_filter ErrorFieldProcChanger.new(args.blank? ? DEFAULT_PROC : args.first), conditions
                end
            end
        end
    end
end