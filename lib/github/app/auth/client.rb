require "octokit"

module GitHub
  module App
    module Auth
      def client(options = {})
        Octokit::Client.new(options)
      end
    end
  end
end
