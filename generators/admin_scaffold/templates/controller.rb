class <%= controller_class_name %>Controller < Admin::BaseController
    # GET /<%= table_name %>
    def index
        @<%= table_name %> = <%= class_name %>.find(:all)
    end

    # GET /<%= table_name %>/new
    def new
        @<%= file_name %> = <%= class_name %>.new
    end

    # GET /<%= table_name %>/1/edit
    def edit
        @<%= file_name %> = <%= class_name %>.find(params[:id])
    end

    # POST /<%= table_name %>
    def create
        @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])

        if @<%= file_name %>.save
            flash[:notice] = '<%= class_name %> was successfully created.'
            redirect_to(@<%= file_name %>)
        else
            render :action => "new" }
        end
    end

    # PUT /<%= table_name %>/1
    def update
        @<%= file_name %> = <%= class_name %>.find(params[:id])

        if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
            flash[:notice] = '<%= class_name %> was successfully updated.'
            redirect_to(@<%= file_name %>)
        else
            render :action => "edit"
        end
    end
    
    # DELETE /<%= table_name %>/1
    def destroy
        @<%= file_name %> = <%= class_name %>.find(params[:id])
        @<%= file_name %>.destroy

        flash[:notice] = '<%= class_name %> was successfully deleted.'        
        redirect_to(<%= table_name %>_url)
    end
end