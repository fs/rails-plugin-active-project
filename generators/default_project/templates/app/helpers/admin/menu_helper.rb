module Admin::MenuHelper

	def menu_top
		Menu.new('admin').show do |item|
#			if restrict_to(item.roles)
				if active_top_menu == item.key
					content_tag('li', link_to(item.title, item.url), :class => 'here')
				else
					content_tag('li', link_to(item.title, item.url))
				end 
#			end
		end
	end

	def menu_sub
		Menu.new('admin').show(active_top_menu) do |item|
#			if restrict_to(item.roles)
				if active_sub_menu == item.key
					content_tag('li', link_to(item.title, item.url), :class => 'here')
				else
					content_tag('li', link_to(item.title, item.url))
				end 
#			end
		end
	end
end
