module ActiveProject #:nodoc:
    module RailsExt #:nodoc:
        module ActionPack #:nodoc:        
            module Helpers #:nodoc:   
                
                module TextileTextArea
    
                    def self.included(base)
                        base.send(:include, InstanceMethods)
                    end

                    module InstanceMethods
                        def textile_text_area(method, options = {})
                            sanitized_object_name = tag_id = @object_name.gsub(/[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
                            tag_id = "#{sanitized_object_name}_#{method}"
                            
                            
                            @template.content_for :head do
                                returning '' do |html|
                                    html << @template.stylesheet_link_tag('textile_editor')
                                    html <<@template.javascript_include_tag('textile_editor')
                                end
                            end
                            
                            @template.content_for :head_javascript do
                                <<-JS
                                Event.observe(window, 'load', function() {
                                    TextileEditor.initialize('#{tag_id}', 'extended');
                                });
                                JS
                            end
                            
                            @template.text_area(@object_name, method, objectify_options(options))
                        end

                    end
                end
                
            end
        end
    end
end

class ActionView::Helpers::FormBuilder
    include ActiveProject::RailsExt::ActionPack::Helpers::TextileTextArea
end