require 'rake'

begin
  Bundler.require
rescue LoadError
  abort '### Please install the "bundler" gem ###'
end

begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

ensure_in_path 'lib'
require 'rawr/rawr_version'

Bones {

name  'rawr'
authors  'James Britt, Logan Barnett, David Koontz'
email  'james@neurogami.com'
url  'http://github.com/rawr/rawr'
version  Rawr::VERSION
readme_file  'README.md'
summary  "Rawr is a packaging and deployment solution for JRuby applications."
rdoc_exclude  %w(.git launch4j lib/rawr/launch4j lib/rawr/templates )
ruby_opts  []
exclude %w{.rvmrc data/website .git}
libs << 'lib'
gem.dependencies  %w{ user-choices rubyzip }
gem.platform  "java"
gem.need_tar false
gem.need_zip false

}

# task :default => 'spec'

task :update_version_readme do
  readme = IO.readlines( 'README.md')
  File.open( 'README.md', 'w' ) do |f| 
    f.puts "Rawr #{Rawr::VERSION}\n"
    readme.shift
    f.puts readme
  end
end

task 'gem:package' => [:update_version_readme]
gem 'rspec', '1.3.0'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('specs:run') do |t|
  t.spec_files = FileList['test/**/*_spec.rb']
end



task :default => :gem
