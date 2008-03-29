namespace :svn do
    desc "Configure Subversion for Rails"
    task :configure do
        %x[ svn remove log --force ]
        %x[ svn commit -m 'removing log directory' ]
        %x[ svn propset svn:ignore 'log' . --force ]
        %x[ svn update . ]
        %x[ svn commit -m 'Ignoring log directory' ]
            
        %x[ svn remove tmp/* --force ]
        %x[ svn propset svn:ignore '*' tmp/* ]
        %x[ svn commit -m 'Ignoring all files in /tmp/' ]
        
        %x[ svn propset svn:ignore '*.sqlite3\ndevelopment_structure.sql\nschema.rb' db/ --force ]
        %x[ svn update db/ ]
        %x[ svn commit -m 'Ignoring schema and all files in /db/ ending in .sqlite3' ]
    end
    
    task :st do
        puts %x[svn st]
    end

    task :up do
        puts %x[svn up]
    end

    desc "Adds all new files to the subversion"    
    task :add do
        %x[svn st].split(/\n/).each do |line|
            trimmed_line = line.delete('?').lstrip
            if line[0,1] =~ /\?/
                %x[svn add #{trimmed_line}]
                puts %[added #{trimmed_line}]
            end
        end
    end
    
    desc "Deletes all localy deleted files from subversion"    
    task :delete do
        %x[svn st].split(/\n/).each do |line|
            trimmed_line = line.delete('!').lstrip
            if line[0,1] =~ /\!/
                %x[svn rm #{trimmed_line}]
                puts %[removed #{trimmed_line}]
            end
        end
    end
end