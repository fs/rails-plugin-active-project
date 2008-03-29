module Admin::ListTableHelper

	def list_table_title
		render :partial => 'admin/shared/list_table_title'
	end

	def list_table_pagination(pages)
		render :partial => 'admin/shared/list_table_pagination', :object => pages
	end

end
