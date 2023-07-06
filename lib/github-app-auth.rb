require "github-app-auth/app"
require "github-app-auth/app_installation"
require "github-app-auth/version"

module GitHub
  module App
    module Auth
      class Error < StandardError; end
      class InstallationError < Error; end
      class TokenError< Error; end

      class AuthClass
        include GitHub::App::Auth
      end
    end
  end
end
