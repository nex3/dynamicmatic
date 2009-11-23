begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "dynamicmatic"
    gemspec.summary = "Dynamic StaticMatic pages with Sinatra."
    gemspec.description = <<DESCRIPTION
DynamicMatic is a tiny Sinatra extension that integrates Sinatra with StaticMatic.
It allows most of your site to be static
while having a few dynamic pages that can use the StaticMatic layouts and partials.
DESCRIPTION
    gemspec.email = "nex342@gmail.com"
    gemspec.homepage = "http://github.com/nex3/dynamicmatic"
    gemspec.authors = ["Nathan Weizenbaum"]
    gemspec.add_dependency 'sinatra', '>= 0.10.1'
    gemspec.add_dependency 'staticmatic', '>= 0.10.7'
    gemspec.has_rdoc = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
