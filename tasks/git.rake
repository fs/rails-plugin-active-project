namespace :git do

    desc "Adds remote origin git.toa repository. Specify PROJECT env variable"
    task :add_origin do
    	raise('Please, specify PROJECT env variable') if ENV['PROJECT'].blank?
    
    	`git remote add origin git@git.toa:prj/#{ENV['PROJECT']}.git`
    	`git config branch.master.remote origin`
    	`git config branch.master.merge refs/heads/master`
    end
end
