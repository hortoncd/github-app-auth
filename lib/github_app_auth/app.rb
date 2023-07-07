# frozen_string_literal: true

require "jwt"
require "openssl"
require_relative "client"

module GitHub
  module App
    # GitHub App Authentication
    module Auth
      def app_client(options = {})
        client(bearer_token: app_token(options))
      end

      # options: the following can be passed via the options hash.  if missing
      #          they will be read from ENV.
      # github_app_private_key: String, The private key for the GitHub app
      # github_app_id: String, the app id for the GitHub app
      def app_token(options = {})
        # Private key contents
        private_pem = app_private_key(options)
        private_key = OpenSSL::PKey::RSA.new(private_pem)

        # Generate the JWT
        payload = {
          # issued at time, 60 seconds in the past to allow for clock drift
          iat: Time.now.to_i - 60,
          # JWT expiration time (10 minute maximum)
          exp: Time.now.to_i + (10 * 60),
          # GitHub App's identifier
          iss: app_id(options)
        }

        JWT.encode(payload, private_key, "RS256")
      end

      def app_id(options = {})
        options[:github_app_id] || ENV["GITHUB_APP_ID"]
      end

      def app_private_key(options = {})
        options[:github_app_private_key] || ENV["GITHUB_APP_PRIVATE_KEY"]
      end
    end
  end
end
