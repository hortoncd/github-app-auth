require "bundler/setup"
#require_relative "../lib/github/app/auth"

ENV["GITHUB_APP_ID"] = "654321"
ENV["GITHUB_APP_PRIVATE_KEY"] = "BEGIN RSA PRIVATE KEY\nfakefakefake"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "simplecov"
SimpleCov.profiles.define "no_vendor_coverage" do
  add_filter "vendor"
  add_filter "spec"
end

SimpleCov.start "no_vendor_coverage"

require "github/app/auth"
