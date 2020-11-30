# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'spree_loyalty_points/version'

Gem::Specification.new do |s|
  s.name = "spree_loyalty_points"
  s.version = SpreeLoyaltyPoints::VERSION
  s.require_paths = ["lib"]
  s.author = "Jatin Baweja, Sushant Mittal"
  s.description = "To award loyalty points and add loyalty points payment method to spree"
  s.email = "info@vinsol.com"
  s.required_ruby_version = '~> 2.4'
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.test_files = Dir['spec/**/*']
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage = "http://vinsol.com"
  s.licenses = ["MIT"]
  s.summary = "Add loyalty points to spree"

  # if s.respond_to? :specification_version then
  #   s.specification_version = 4
  # end

  # if s.respond_to? :add_runtime_dependency then
  #   s.add_runtime_dependency(%q<solidus>, [">= 0"])
  #   s.add_development_dependency(%q<capybara>, ["~> 2.5"])
  #   s.add_development_dependency(%q<coffee-rails>, ["~> 4.2.1"])
  #   s.add_development_dependency(%q<database_cleaner>, ["~> 1.5.3"])
  #   s.add_development_dependency(%q<factory_girl>, ["~> 4.5"])
  #   s.add_development_dependency(%q<ffaker>, ["~> 2.2.0"])
  #   s.add_development_dependency(%q<rspec-rails>, ["~> 3.4"])
  #   s.add_development_dependency(%q<rspec-activemodel-mocks>, [">= 0"])
  #   s.add_development_dependency(%q<shoulda-matchers>, ["~> 3.1.1"])
  #   s.add_development_dependency(%q<sass-rails>, ["~> 5.0.0"])
  #   s.add_development_dependency(%q<selenium-webdriver>, ["~> 3.0.8"])
  #   s.add_development_dependency(%q<simplecov>, ["~> 0.13.0"])
  #   s.add_development_dependency(%q<sqlite3>, ["~> 1.3.13"])
  # else
  #   s.add_dependency(%q<solidus>, [">= 0"])
  #   s.add_dependency(%q<capybara>, ["~> 2.5"])
  #   s.add_dependency(%q<coffee-rails>, ["~> 4.2.1"])
  #   s.add_dependency(%q<database_cleaner>, ["~> 1.5.3"])
  #   s.add_dependency(%q<factory_girl>, ["~> 4.5"])
  #   s.add_dependency(%q<ffaker>, ["~> 2.2.0"])
  #   s.add_dependency(%q<rspec-rails>, ["~> 3.4"])
  #   s.add_dependency(%q<rspec-activemodel-mocks>, [">= 0"])
  #   s.add_dependency(%q<shoulda-matchers>, ["~> 3.1.1"])
  #   s.add_dependency(%q<sass-rails>, ["~> 5.0.0"])
  #   s.add_dependency(%q<selenium-webdriver>, ["~> 3.0.8"])
  #   s.add_dependency(%q<simplecov>, ["~> 0.13.0"])
  #   s.add_dependency(%q<sqlite3>, ["~> 1.3.13"])
  # end
  solidus_version = [">= 1.0", "< 3"]

  s.add_dependency 'deface', '~> 1.0'
  s.add_dependency 'rspec-activemodel-mocks', '~> 1.1.0'
  s.add_dependency 'shoulda-matchers', '~> 4.0'
  s.add_dependency 'solidus_api', solidus_version
  s.add_dependency 'solidus_backend', solidus_version
  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_support', '~> 0.4.0'

  s.add_development_dependency 'solidus_dev_support'
end
