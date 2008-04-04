module Rails
    module Generator
        class GeneratedAttribute
            
            def field_type_with_textile_text_area
                @field_type ||= case type
                when :text  then :textile_text_area
                else
                    field_type_without_textile_text_area
                end
            end
            alias_method_chain :field_type, :textile_text_area
        end
    end
end

class AdminRspecScaffoldGenerator < Rails::Generator::NamedBase
    default_options :skip_migration => false
  
    attr_reader   :controller_name,
        :controller_class_path,
        :controller_file_path,
        :controller_class_nesting,
        :controller_class_nesting_depth,
        :controller_class_name,
        :controller_singular_name,
        :controller_plural_name,
        :resource_edit_path,
        :default_file_extension,
        :admin_namespace_path,
        :admin_class_name
    alias_method  :controller_file_name,  :controller_singular_name
    alias_method  :controller_table_name, :controller_plural_name

    def initialize(runtime_args, runtime_options = {})
        super 

        @controller_name = @name.pluralize
        base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
        @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)
        
        @admin_namespace_path = 'admin'
        @admin_class_name = @admin_namespace_path.classify
        
        @controller_class_path = File.join(@admin_namespace_path, @controller_class_path)
        
        if @controller_class_nesting.empty?
            @controller_class_name = "#{@admin_class_name}::#{@controller_class_name_without_nesting}"
        else
            @controller_class_name = "#{@admin_class_name}::#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
        end
        
        @class_name_without_nesting, @singular_name, @plural_name = inflect_names(@name.underscore.singularize.gsub('/', '_'))
        @class_name = @plural_name.classify
    end

    def manifest
        record do |m|
      
            # Check for class naming collisions.
            m.class_collisions("#{controller_class_name}Controller", "#{controller_class_name}Helper")

            # Controller, helper, views, and spec directories.
            m.directory(File.join('app/controllers', controller_class_path))
            m.directory(File.join('app/helpers', controller_class_path))
            m.directory(File.join('app/views', controller_class_path, controller_file_name))
#            m.directory(File.join('spec/controllers', controller_class_path))
#            m.directory(File.join('spec/helpers', class_path))
#            m.directory File.join('spec/fixtures', class_path)
#            m.directory File.join('spec/views', controller_class_path, controller_file_name)
      
            # Controller spec, class, and helper.
#            m.template 'routing_spec.rb',
#                File.join('spec/controllers', controller_class_path, "#{controller_file_name}_routing_spec.rb")
#
#            m.template 'controller_spec.rb',
#                File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")
#
            m.template "app/controllers/controller.rb",
                File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
#
#            m.template 'helper_spec.rb',
#                File.join('spec/helpers', class_path, "#{controller_file_name}_helper_spec.rb")

            m.template "app/helpers/helper.rb",
                File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb")

            for action in scaffold_views
                m.template(
                    "app/views/#{action}.html.erb",
                    File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.erb")
                )
            end
      
            # Model class, unit test, and fixtures.
            m.template 'model:model.rb', File.join('app/models', "#{file_name}.rb")
#            m.template 'model:fixtures.yml', File.join('spec/fixtures', "#{table_name}.yml")
#            m.template 'rspec_model:model_spec.rb', File.join('spec/models', "#{file_name}_spec.rb")

            # View specs
#            m.template "rspec_scaffold:edit_erb_spec.rb",
#                File.join('spec/views', controller_class_path, controller_file_name, "edit.html.erb_spec.rb")
#            m.template "rspec_scaffold:index_erb_spec.rb",
#                File.join('spec/views', controller_class_path, controller_file_name, "index.html.erb_spec.rb")
#            m.template "rspec_scaffold:new_erb_spec.rb",
#                File.join('spec/views', controller_class_path, controller_file_name, "new.html.erb_spec.rb")
#            m.template "rspec_scaffold:show_erb_spec.rb",
#                File.join('spec/views', controller_class_path, controller_file_name, "show.html.erb_spec.rb")

            unless options[:skip_migration]
                m.migration_template(
                    'model:migration.rb', 'db/migrate', 
                    :assigns => {
                        :migration_name => "Create#{class_name}",
                        :attributes     => attributes
                    }, 
                    :migration_file_name => "create_#{file_name}"
                )
            end
        end
    end

    protected
    
    # Override with your own usage banner.
    def banner
        "Usage: #{$0} rspec_scaffold ModelName [field:type field:type]"
    end

    def add_options!(opt)
        opt.separator ''
        opt.separator 'Options:'
        opt.on("--skip-migration", 
            "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
    end

    def scaffold_views
        %w[ index new edit _form]
    end
end
