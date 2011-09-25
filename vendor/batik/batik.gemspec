require File.expand_path('../lib/batik', __FILE__)

Gem::Specification.new do |s|
  s.name          = "batik"
  s.version       = Batik::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Evgeni Dzhelyov"]
  s.homepage      = "http://github.com/edzhelyov/s9-e1"
  s.summary       = "Wraps Java's Batik SVG library into friendly interface"
  s.description   = "Wraps Java's Batik SVG library into friendly interface"

  s.files         = Dir["{lib}/**/*"] + ["Gemfile", "README.md"]

  s.add_development_dependency "rspec", ">2.0"
end
