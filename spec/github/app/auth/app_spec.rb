require_relative "../../../spec_helper.rb"

RSpec.describe GitHub::App::Auth do
  # Use the class we provide to test the module
  subject { GitHub::App::Auth::AuthClass.new }

  describe ".app_client" do
    let(:github_client) { instance_double(Octokit::Client) }

    it "returns an Octokit::Client authorized to an app" do
      expect(subject).to receive(:app_token).and_return("test-token")
      expect(subject.app_client).to be_kind_of(Octokit::Client)
    end
  end

  describe ".app_token" do
    let(:app_private_key) { OpenSSL::PKey::RSA.new(2048) }

    it "returns a JWT token for for an app" do
      expect(OpenSSL::PKey::RSA).to receive(:new)
                                .with(app_private_key.to_pem)
                                .and_return(app_private_key)
      expect(JWT).to receive(:encode).with(any_args).and_return("test-token")
      expect(subject.app_token(github_app_private_key: app_private_key.to_pem)).to eq("test-token")
    end
  end

  describe ".app_id" do
    before(:each) do
      @app_id = "123456"
      @gh_app_id = ENV["GITHUB_APP_ID"]
      ENV["GITHUB_APP_ID"] = @app_id
    end

    after(:each) do
      ENV["GITHUB_APP_ID"] = @gh_app_id
    end

    let(:options)  {
      {
        github_app_id: @app_id
      }
    }

    it "uses the app id from options" do
      expect(subject.app_id(options)).to eq(@app_id)
    end

    it "uses the app id from the ENV" do
      expect(subject.app_id).to eq(@app_id)
    end
  end

  describe ".app_private_key" do
    before(:each) do
      @app_private_key = OpenSSL::PKey::RSA.new(2048).to_pem
      @gh_app_private_key = ENV["GITHUB_APP_PRIVATE_KEY"]
      ENV["GITHUB_APP_PRIVATE_KEY"] = @app_private_key
    end

    after(:each) do
      ENV["GITHUB_APP_PRIVATE_KEY"] = @gh_app_private_key
    end

    let(:options)  {
      {
        github_app_private_key: @app_private_key
      }
    }

    it "uses the private key from options" do
      expect(subject.app_private_key(options)).to eq(@app_private_key)
    end

    it "uses the app id from the ENV" do
      expect(subject.app_private_key).to eq(@app_private_key)
    end
  end
end
