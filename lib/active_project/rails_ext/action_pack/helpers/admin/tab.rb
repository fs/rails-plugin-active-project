module ActiveProject #:nodoc:
    module RailsExt #:nodoc:
        module ActionPack #:nodoc:        
            module Helpers #:nodoc:        
                module Admin #:nodoc:        

                    module Tab
    
                        class Tab
        
                            public
        
                            def initialize(tab_id, context, block)
                                @tab_id = "#{tab_id}_tabs"
                                @context = context
                                @block = block
        
                                render_tabs_content 
            
                                if @tabs.size > 1
                                    puts_js
                                    puts_tabs
                                end
 
                                puts_tabs_content            
                            end

                            def method_missing(id, name = '', &block)
                                # FIX this ugly workaround
                                super if id.to_s == '_erbout'
            
                                @tabs << {
                                    :id     => id,
                                    :name   => name.blank? ? id.to_s.humanize : name
                                }

                                html = @context.capture(&block)            
                                @context.concat(@context.content_tag(:fieldset, html, :id => id), @block.binding)
                            end

        
                            private
        
                            def render_tabs_content
                                @tabs = []
                                @tabs_content = @context.capture(self, &@block)
                            end
        
                            def puts_tabs_content
                                @context.concat(@tabs_content, @block.binding)
                            end
        
                            def puts_js
                                @context.content_for :head_javascript do
                                    <<-JS
                                    document.observe('contentloaded', function() {
                                        new Control.Tabs('#{@tab_id}');
                                    });
                                    JS
                                end
                            end
        
                            def puts_tabs
            
                                html = @context.content_tag(:ul, :class => "tab_group", :id => @tab_id) do
                                    returning '' do |li|
                                        @tabs.each do |item|
                                            li << @context.content_tag(:li, @context.content_tag(:a, item[:name], :href => "##{item[:id]}"))
                                        end
                                    end                
                                end
            
                                @context.concat(html, @block.binding)
                            end
        
                        end

                        # tabs(:posts) do |tab|
                        #     tab.first do
                        #         Content for primary tab
                        #     end
                        #     tab.second do
                        #         Content for second tab
                        #     end
                        # end
                        def tabs(tab_id, &block)
                            Tab.new(tab_id, self, block)
                        end
                    end

                end
            end
        end
    end
end