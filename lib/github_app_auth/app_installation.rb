# frozen_string_literal: true

module GitHub
  module App
    # GitHub App Installation Authentication
    module Auth
      def organization_installation_client(org, options = {})
        client(bearer_token: organization_installation_token(org, options))
      end

      def organization_installation_token(org, options = {})
        installation_token(:organization, org, options)
      end

      def repository_installation_client(repo, options = {})
        client(bearer_token: repository_installation_token(repo, options))
      end

      def repository_installation_token(repo, options = {})
        installation_token(:repository, repo, options)
      end

      def user_installation_client(user, options = {})
        client(bearer_token: user_installation_token(user, options))
      end

      def user_installation_token(user, options = {})
        installation_token(:user, user, options)
      end

      # Supported types are :organization, :repository, :user
      def installation_token(type, name, options = {})
        application_client(options)
        installation = installation_by_type(type, name)

        if installation.nil? || installation[:id].nil?
          raise GitHub::App::Auth::InstallationError, "Could not find installation for #{type}: #{name}"
        end

        resp = application_client.create_app_installation_access_token(installation[:id])
        if resp.nil? || resp[:token].nil?
          raise GitHub::App::Auth::TokenError, "Could not generate installation token for #{type}: #{name}"
        end

        resp[:token]
      end

      def installation_by_type(type, name)
        case type
        when :organization
          application_client.find_organization_installation(name)
        when :repository
          application_client.find_repository_installation(name)
        when :user
          application_client.find_user_installation(name)
        else
          raise ArgumentError, "Unsupported installation type: #{type}"
        end
      end

      def application_client(options = {})
        @application_client ||= app_client(options)
      end
    end
  end
end
