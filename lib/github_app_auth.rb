# frozen_string_literal: true

require "github_app_auth/app"
require "github_app_auth/app_installation"
require "github_app_auth/version"

module GitHub
  module App
    # GitHub App Authentication
    module Auth
      class Error < StandardError; end
      class InstallationError < Error; end
      class TokenError < Error; end

      class AuthClass
        include GitHub::App::Auth
      end
    end
  end
end
