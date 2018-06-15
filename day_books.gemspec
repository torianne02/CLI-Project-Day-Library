
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "day_books/version"

Gem::Specification.new do |spec|
  spec.name          = "day_books"
  spec.version       = DayBooks::VERSION
  spec.authors       = ["Victoria Fluharty"]
  spec.email         = ["victoria.fluharty@gmail.com"]

  spec.summary       = %q{Interactive library for famous author, Sylvia Day's books.}
  spec.description   = %q{Library that lists all of the books written by Sylvia Day using Goodreads website. Allows user to see a list of her books and pick a book to see the description.}
  spec.homepage      = "https://github.com/torianne02/CLI-Project-Day-Library"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["day_books"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "require_all"
end