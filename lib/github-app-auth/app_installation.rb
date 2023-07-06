module GitHub
  module App
    module Auth
      # legacy support because original only supported repo
      def app_installation_client(repo, options = {})
        puts "DEPRECATED: app_installation_client will be removed in v0.4.0, use repository_installation_client instead"
        client(bearer_token: app_installation_token(repo, options))
      end

      def app_installation_token(repo, options = {})
        puts "DEPRECATED: app_installation_token will be removed in v0.4.0, use repository_installation_token instead"
        installation_token(:repository, repo, options)
      end

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
        application_client = app_client(options)
        installation = begin
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

        if installation.nil? || installation[:id].nil?
          raise GitHub::App::Auth::InstallationError, "Could not find installation for #{type}: #{name}"
        end

        resp = application_client.create_app_installation_access_token(installation[:id])
        if resp.nil? || resp[:token].nil?
          raise GitHub::App::Auth::TokenError, "Could generate installation token for #{type}: #{name}"
        end
        resp[:token]
      end
    end
  end
end
