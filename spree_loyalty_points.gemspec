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
  s.homepage = "https://github.com/taminhtien/spree-loyalty-points"
  s.licenses = ["MIT"]
  s.summary = "Add loyalty points to spree"

  if s.respond_to?(:metadata)
    s.metadata["homepage_uri"] = s.homepage if s.homepage
    s.metadata["source_code_uri"] = s.homepage if s.homepage
  end

  solidus_version = [">= 1.0", "< 4"]

  s.add_dependency 'deface', '~> 1.0'
  s.add_dependency 'rabl', '~> 0.14.3'
  s.add_dependency 'rspec-activemodel-mocks', '~> 1.1.0'
  s.add_dependency 'shoulda-matchers', '~> 4.0'
  s.add_dependency 'solidus_api', solidus_version
  s.add_dependency 'solidus_backend', solidus_version
  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_support', '~> 0.5.0'

  s.add_development_dependency 'solidus_dev_support'
end
