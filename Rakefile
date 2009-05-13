require 'rubygems'
require 'rake'

$LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
require 'repaginator'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = "repaginator"
    gem.summary = %Q{High-performance content pagination engine with Memcache interface}
    gem.version = Repaginator::VERSION
    gem.email = "github@tadman.ca"
    gem.homepage = "http://github.com/tadman/repaginator"
    gem.authors = [ "Scott Tadman" ]
    
    gem.executables = %w[ repaginator ]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "repaginator #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
