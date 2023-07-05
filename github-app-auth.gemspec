require_relative 'lib/github/app/auth/version'

Gem::Specification.new do |spec|
  spec.name          = "github-app-auth"
  spec.version       = GitHub::App::Auth::VERSION
  spec.authors       = ["Chris Horton"]
  spec.email         = ["hortoncd@gmail.com"]

  spec.summary       = %q{GitHub App auth methods.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/hortoncd/github-app-auth"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = "#{spec.homepage}"
  spec.metadata["source_code_uri"] = "#{spec.homepage}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
  spec.add_dependency "jwt", "~> 2.7"
  spec.add_dependency "octokit", "~> 6.1"
  spec.add_dependency "openssl", "~> 3.1"
end
