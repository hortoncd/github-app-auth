module GitHub
  module App
    module Auth
      def app_installation_client(repo, options = {})
        client(bearer_token: app_installation_token(repo, options))
      end

      def app_installation_token(repo, options = {})
        application_client = app_client
        installation = application_client.find_repository_installation(repo)
        resp = application_client.create_app_installation_access_token(installation[:id])
        resp[:token]
      end
    end
  end
end
