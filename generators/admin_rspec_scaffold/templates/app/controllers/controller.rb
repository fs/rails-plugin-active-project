class <%= controller_class_name %>Controller < <%= admin_class_name %>::BaseController
    # GET /<%= admin_namespace_path %>/<%= plural_name %>
    # GET /<%= admin_namespace_path %>/<%= plural_name %>.xml
    def index
        @<%= plural_name %> = <%= class_name %>.paginate(:page => params[:page], :per_page => APP_CONFIG['per_page'])

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @<%= plural_name %> }
        end
    end

    # GET /<%= admin_namespace_path %>/<%= plural_name %>/new
    # GET /<%= admin_namespace_path %>/<%= plural_name %>/new.xml
    def new
        @<%= singular_name %> = <%= class_name %>.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @<%= singular_name %> }
        end
    end

    # GET /<%= admin_namespace_path %>/<%= plural_name %>/1/edit
    def edit
        @<%= singular_name %> = <%= class_name %>.find(params[:id])
    end

    # POST /<%= admin_namespace_path %>/<%= plural_name %>
    # POST /<%= admin_namespace_path %>/<%= plural_name %>.xml
    def create
        @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])

        respond_to do |format|
            if @<%= singular_name %>.save
                flash[:notice] = '&quot;<%= singular_name.humanize %>&quot; was successfully created.'
                format.html { redirect_to(<%= admin_namespace_path %>_<%= plural_name %>_url) }
                format.xml  { render :xml => @<%= singular_name %>, :status => :created, :location => @<%= singular_name %> }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /<%= admin_namespace_path %>/<%= plural_name %>/1
    # PUT /<%= admin_namespace_path %>/<%= plural_name %>/1.xml
    def update
        @<%= singular_name %> = <%= class_name %>.find(params[:id])

        respond_to do |format|
            if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
                flash[:notice] = '&quot;<%= singular_name.humanize %>&quot; was successfully updated.'
                format.html { redirect_to(<%= admin_namespace_path %>_<%= plural_name %>_url) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /<%= admin_namespace_path %>/<%= plural_name %>/1
    # DELETE /<%= admin_namespace_path %>/<%= plural_name %>/1.xml
    def destroy
        @<%= singular_name %> = <%= class_name %>.find(params[:id])
        @<%= singular_name %>.destroy

        respond_to do |format|
            format.html { redirect_to(<%= admin_namespace_path %>_<%= plural_name %>_url) }
            format.xml  { head :ok }
        end
    end
end
