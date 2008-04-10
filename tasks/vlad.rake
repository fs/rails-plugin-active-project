if Object.const_defined? :Vlad

    namespace :vlad do
        namespace :git do
            task :update do
                `git pull && git push fs`
            end
        end
    
        remote_task :setup_app, :roles => :app do
            run "sudo chown -R #{mongrel_user}.#{mongrel_group} #{shared_path}/*"
            run "sudo chmod -R ug+rw #{shared_path}/*"
        end
    
        remote_task :update_permissions do
            run "sudo chown -R #{mongrel_user}.#{mongrel_group} #{current_path}/*"
            run "sudo chmod -R ug+rw #{current_path}/*"
        end
    
        remote_task :update => 'vlad:git:update' do
            Rake::Task['vlad:update_permissions'].invoke
        end
    end

end
