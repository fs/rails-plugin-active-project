module ActiveProject #:nodoc:
    module RailsExt #:nodoc:
        module ActionPack #:nodoc:        
            module Helpers #:nodoc:        
                module Admin #:nodoc:
                    module Menu
                        def menu_top(menu = 'admin')
                            ::Menu.new(menu).show do |item|
#                                restrict_to(item.roles) do
                                    if active_top_menu.to_s == item.key.to_s
                                        content_tag('li', link_to(item.title, item.url), :class => 'here')
                                    else
                                        content_tag('li', link_to(item.title, item.url))
                                    end 
#                                end
                            end
                        end

                        def menu_sub(menu = 'admin')
                            ::Menu.new(menu).show(active_top_menu) do |item|
#                                restrict_to(item.roles) do
                                    if active_sub_menu == item.key
                                        content_tag('li', link_to(item.title, item.url), :class => 'here')
                                    else
                                        content_tag('li', link_to(item.title, item.url))
                                    end 
#                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
