namespace :git do

    desc "Adds remote origin git.toa reposytory. Specify PROJECT env variable"
    task :add_origin do
    	raise('Please, specify PROJECT env variable') if ENV['PROJECT'].blank?
    
    	`"git add remote origin git@git.toa:#{ENV['PROJECT']}.git"`
    	`git config branch.master.remote origin`
    	`git config branch.master.merge refs/heads/master`
    end
end
