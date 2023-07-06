require_relative "../../../spec_helper"

RSpec.describe GitHub::App::Auth do
  # Use the class we provide to test the module
  subject { GitHub::App::Auth::AuthClass.new }

  let(:github_client) { instance_double(Octokit::Client) }
  let(:installation_id) { "54321" }
  let(:org) { "test-org" }
  let(:repo) { "test/test-repo" }
  let(:token) { "test-token" }
  let(:user) { "test-user" }

  describe ".app_installation_client" do
    it "returns an Octokit::Client authorized to an app installation" do
      expect(subject).to receive(:app_installation_token)
                     .with(repo, {})
                     .and_return("test-token")
      expect(subject.app_installation_client(repo)).to be_kind_of(Octokit::Client)
    end

    it "returns an Octokit::Client authorized to an app installation" do
      expect(subject).to receive(:app_installation_token)
                     .with(repo, {})
                     .and_return("test-token")
      expected_output = "DEPRECATED: app_installation_client will be removed in v0.4.0, use repository_installation_client instead\n"
      expect { subject.app_installation_client(repo) }.to output(expected_output).to_stdout
    end
  end

  describe ".app_installation_token" do
    it "returns a JWT token for for an app" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: token)
      expect(subject.app_installation_token(repo)).to eq(token)
    end

    it "outputs a deprecation notice" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: token)
      expected_output = [
        "DEPRECATED: app_installation_client will be removed in v0.4.0, use repository_installation_client instead",
        "DEPRECATED: app_installation_token will be removed in v0.4.0, use repository_installation_token instead\n"
      ].join("\n")
      expect { subject.app_installation_client(repo) }.to output(expected_output).to_stdout
    end
  end

  describe ".organization_installation_client" do
    it "returns an Octokit::Client authorized to an organization installation" do
      expect(subject).to receive(:organization_installation_token)
                     .with(org, {})
                     .and_return(token)
      expect(subject.organization_installation_client(org)).to be_kind_of(Octokit::Client)
    end
  end

  describe ".organization_installation_token" do
    it "returns a JWT token for for an app" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_organization_installation)
                           .with(org)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: token)
      expect(subject.organization_installation_token(org)).to eq("test-token")
    end
  end

  describe ".repository_installation_client" do
    it "returns an Octokit::Client authorized to a repo installation" do
      expect(subject).to receive(:repository_installation_token)
                     .with(repo, {})
                     .and_return(token)
      expect(subject.repository_installation_client(repo)).to be_kind_of(Octokit::Client)
    end
  end

  describe ".repository_installation_token" do
    it "returns a JWT token for for a repo" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: token)
      expect(subject.repository_installation_token(repo)).to eq(token)
    end
  end

  describe ".user_installation_client" do
    it "returns an Octokit::Client authorized to a user installation" do
      expect(subject).to receive(:user_installation_token)
                     .with(user, {})
                     .and_return(token)
      expect(subject.user_installation_client(user)).to be_kind_of(Octokit::Client)
    end
  end

  describe ".user_installation_token" do
    it "returns a JWT token for for a user" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_user_installation)
                           .with(user)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: token)
      expect(subject.user_installation_token(user)).to eq(token)
    end
  end

  describe ".installation_token" do
    it "raises an error for unsupported installation type" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect { subject.installation_token("unsupported", {}) }.to raise_error(ArgumentError)
    end

    it "raises an error if no installation id is found" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(token: nil)
      expect { subject.installation_token(:repository, repo, {}) }.to raise_error(GitHub::App::Auth::InstallationError)
    end

    it "raises an error if no installation is returned" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(nil)
      expect { subject.installation_token(:repository, repo, {}) }.to raise_error(GitHub::App::Auth::InstallationError)
    end

    it "raises an error if no token is returned" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(token: nil)
      expect { subject.installation_token(:repository, repo, {}) }.to raise_error(GitHub::App::Auth::TokenError)
    end

    it "raises an error if resp is nil for token creation" do
      expect(subject).to receive(:app_client)
                     .and_return(github_client)
      expect(github_client).to receive(:find_repository_installation)
                           .with(repo)
                           .and_return(id: installation_id)
      expect(github_client).to receive(:create_app_installation_access_token)
                           .with(installation_id)
                           .and_return(nil)
      expect { subject.installation_token(:repository, repo, {}) }.to raise_error(GitHub::App::Auth::TokenError)
    end
  end
end
