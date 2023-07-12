# frozen_string_literal: true

require_relative "lib/github_app_auth/version"

Gem::Specification.new do |spec|
  spec.name          = "github-app-auth"
  spec.version       = GitHub::App::Auth::VERSION
  spec.authors       = ["Chris Horton"]
  spec.email         = ["hortoncd@gmail.com"]

  spec.summary       = "GitHub App auth methods."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/hortoncd/github-app-auth"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["homepage_uri"] = spec.homepage.to_s
  spec.metadata["source_code_uri"] = spec.homepage.to_s
  spec.metadata["changelog_uri"] = spec.homepage.to_s

  spec.files = Dir.glob("lib/**/*") + %w[CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md]
  spec.require_paths = ["lib"]
  spec.add_dependency "jwt", "~> 2.7"
  spec.add_dependency "octokit", "~> 6.1"
  spec.add_dependency "openssl", "~> 3.1"
end
