Gem::Specification.new do |gem|
  gem.name              = "dummy_data"
  gem.version           = "0.9.1"
  gem.platform          = Gem::Platform::RUBY
  gem.authors           = ["Gonçalo Silva"]
  gem.email             = ["goncalossilva@gmail.com"]
  gem.homepage          = "http://github.com/goncalossilva/dummy_data"
  gem.summary           = "Uses dummy to generate data for your models and allows you to import it"
  gem.description       = "Uses dummy to generate consistent fake data for your models (including associations) and provides a rake task to import it into the database"
  gem.rubyforge_project = gem.name

  gem.required_rubygems_version = ">= 1.3.6"
  
  gem.add_dependency "dummy", ">= 0.9.1"
  gem.add_dependency "rails", ">= 3.0.0"

  gem.files        = Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "{lib}/**/*.yml", "LICENSE", "*.md"]
  
  gem.require_path = "lib"
end
