class Rails::Generator::Commands::Create
	def trash_directory(dest)
		path = destination_path(dest)
        
		if File.exists?(path)
            logger.rm_rf path
            FileUtils.rm_rf(path)
		else
			logger.missing path
		end
	end
	
	def destroy_file(dest)
		path = destination_path(dest)
        
		if File.exists?(path)
			logger.rm path
			FileUtils.rm(path)
		else
			logger.missing path
		end
	end
end

class Rails::Generator::Commands::Destroy
	def trash_directory(dest)
		return
	end
	
	def destroy_file(dest)
		return
	end	
end

class DefaultProjectGenerator < Rails::Generator::Base
    
    private 
    
    def next_migration_string_with_inc(inc = 1)
        (Time.now.utc.strftime("%Y%m%d%H%M%S").to_i + inc).to_s
    end
    
    public    

	def initialize(runtime_args, runtime_options = {})
		super

        @app_name = File.basename(File.expand_path(RAILS_ROOT))
	end

	def manifest
		record do |m|

			## create base directorys
			%w(
                app/controllers
                app/models
                app/views
                app/observers
                app/mailers
				app/controllers/admin
				app/helpers/admin
				app/views/admin
				app/views/admin/index								
                app/views/admin/sessions
				app/views/admin/layouts
				app/views/admin/shared
                app/views/mailers
                lib/flatsoft
                lib/flatsoft/initializers
                lib/flatsoft/plugins
                lib/flatsoft/admin
                db/bootstrap
				db/yml
				db/yml/menu
                db/yml/config
				public/images/admin
                public/images/textile_editor            
				public/stylesheets/admin
			).each do |d|
				m.directory d
			end
			## end create base directorys			
			
			
			## remove unused directory and files
			%w(test).each do |d|
				m.trash_directory d
			end			
			%w(public/images/rails.png public/index.html public/.htaccess public/dispatch.cgi public/dispatch.fcgi public/dispatch.rb).each do |f|
				m.destroy_file f
			end			
			## end remove unused directory
			
            
			## controllers
			%w(application).each do |f|
				m.file "app/controllers/#{f}.rb", "app/controllers/#{f}.rb"
			end
			%w(base index sessions).each do |f|
				m.file "app/controllers/admin/#{f}_controller.rb", "app/controllers/admin/#{f}_controller.rb"
			end
			## end controllers
			
			
			## models
			%w(menu account account_role account_role_relationship).each do |f|
				m.file "app/models/#{f}.rb", "app/models/#{f}.rb"
			end
			## end models

			
			## helpers
			%w(base index sessions).each do |f|
				m.file "app/helpers/admin/#{f}_helper.rb", "app/helpers/admin/#{f}_helper.rb"
			end
			## end helpers

			
			## views
			%w(
				layouts/base layouts/sessions
				shared/_list_table_pagination shared/_list_table_title shared/_messages
				index/index
                sessions/new
			).each do |f|
				m.file "app/views/admin/#{f}.html.erb", "app/views/admin/#{f}.html.erb"
			end
			## end view
			

			## configs
			%w(routes initializers/app).each do |f|
                m.file "config/#{f}.rb", "config/#{f}.rb"
			end
			## end config

            
			## yml config
			m.file "db/yml/menu/admin.yml", "db/yml/menu/admin.yml"
			m.template "db/yml/config/app.yml", "db/yml/config/app.yml", :assigns => { :app_name => @app_name }
			## yml
            
            
			## libs
			%w(initializer initializers/config initializers/mailer).each do |f|
                m.file "lib/flatsoft/#{f}.rb", "lib/flatsoft/#{f}.rb"
			end
			%w(base acl_system authenticated_system rescue_system).each do |f|
                m.file "lib/flatsoft/#{f}.rb", "lib/flatsoft/#{f}.rb"
			end
			%w(base authenticated_system rescue_system).each do |f|
                m.file "lib/flatsoft/admin/#{f}.rb", "lib/flatsoft/admin/#{f}.rb"
			end
			## end libs
            
            ## migrates
            %w(create_accounts create_account_roles create_account_role_relationships).each_with_index do |f, i|
                m.file "db/migrate/#{f}.rb", "db/migrate/#{next_migration_string_with_inc(i)}_#{f}.rb"
			end            
            %w(account_role_relationships account_roles accounts).each do |f|
                m.file "db/bootstrap/#{f}.yml", "db/bootstrap/#{f}.yml"
			end            
            ## end migrates

			
			## public images
			%w(indicator.gif rss.gif success-bg.gif).each do |f|
				m.file "public/images/admin/#{f}", "public/images/admin/#{f}"
			end
			%w(sort_asc.gif sort_desc.gif).each do |f|
				m.file "public/images/#{f}", "public/images/#{f}"
			end
			%w(background bold h1 h3 h5 indent justify list_bullets omega paragraph strikethrough blockquote center h2 h4 h6 italic left list_numbers outdent right underline).each do |f|
				m.file "public/images/textile_editor/#{f}.png", "public/images/textile_editor/#{f}.png"
			end
			## end public images
			
			
			## public javascript
			%w(control_tabs textile_editor textile_editor_config).each do |f|
				m.file "public/javascripts/#{f}.js", "public/javascripts/#{f}.js"
			end
			## end javascript


			## public stylesheets            
			%w(textile_editor).each do |f|
				m.file "public/stylesheets/#{f}.css", "public/stylesheets/#{f}.css"
			end
			%w(grid  login  menu  mixed  reset  tab  typography).each do |f|
				m.file "public/stylesheets/admin/#{f}.css", "public/stylesheets/admin/#{f}.css"
			end
			## end stylesheets
		end
	end
end
