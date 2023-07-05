require_relative "../../../spec_helper"

RSpec.describe GitHub::App::Auth do
  # Use the class we provide to test the module
  subject { GitHub::App::Auth::AuthClass.new }

  describe ".app_installation_client" do
    let(:repo) { "test/test-repo" }

    it "returns an Octokit::Client authorized to an app" do
      expect(subject).to receive(:app_installation_token)
                               .with(repo, {})
                               .and_return("test-token")
      expect(subject.app_installation_client(repo)).to be_kind_of(Octokit::Client)
    end
  end

  describe ".app_installation_token" do
    let(:github_client) { instance_double(Octokit::Client) }

    let(:installation_id) { "54321" }

    let(:repo) { "test/test-repo" }

    it "returns a JWT token for for an app" do
      expect(subject).to receive(:app_client)
                               .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with("test/test-repo")
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: "test-token")
      expect(subject.app_installation_token(repo)).to eq("test-token")
    end
  end
end
