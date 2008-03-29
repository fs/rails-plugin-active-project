require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :test

desc "Test the active_project plugin."
Spec::Rake::SpecTask.new(:test) do |t|
    t.spec_opts = ["--format", "specdoc"]
    t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :test do
    desc "Test the active_project plugin with color output "
    Spec::Rake::SpecTask.new(:color) do |t|
        t.spec_opts = ["--format", "specdoc", "--color"]
        t.spec_files = FileList['spec/**/*_spec.rb']
    end
end

desc 'Generate documentation for the active_project plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title    = 'ActiveProject'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README')
    rdoc.rdoc_files.include('lib/**/*.rb')
end
