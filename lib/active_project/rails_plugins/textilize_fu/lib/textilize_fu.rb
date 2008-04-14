module Flatsoft
    module Plugins
        module TextilizeFu
            class << self
                def translate(str)
                    RedCloth.new(str).to_html
                end
            end
            
            def self.included(base)
                base.extend ClassMethods
                
                class << base
                    attr_accessor :textilize_attributes
                end
            end
            
            module ClassMethods
                # Specifies the given field(s) as using textile, meaning it is passed through TextilizeFu.translate and set to the html_field.  
                #
                #   class Foo < ActiveRecord::Base
                #     # stores the html version of body in body_html
                #     textilize :body
                #   end
                #
                def textilize(*attrs)
                    self.textilize_attributes  = attrs
                    
                    before_save :create_textilized_field
                end
            end
            
            protected
            
            def textilized_field_name(attr)
                "#{attr}_html"
            end
            
            def create_textilized_field
                self.class.textilize_attributes.each do |attr|
                    send("#{textilized_field_name(attr)}=", TextilizeFu.translate(send(attr))) unless send(attr).nil?
                end
            end
            
        end
    end
end