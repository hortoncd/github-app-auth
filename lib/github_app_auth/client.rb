# frozen_string_literal: true

require "octokit"

module GitHub
  module App
    # GitHub App client
    module Auth
      def client(options = {})
        Octokit::Client.new(options)
      end
    end
  end
end
