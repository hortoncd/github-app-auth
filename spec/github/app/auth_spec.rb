require_relative "../../spec_helper"

RSpec.describe GitHub::App::Auth do
  it "has a version number" do
    expect(GitHub::App::Auth::VERSION).not_to be nil
  end

  it "provides a class that includes the module's methods" do
    auth = GitHub::App::Auth::AuthClass.new
    expect(auth).to be_kind_of(GitHub::App::Auth::AuthClass)
    expect(auth.public_methods).to include(:app_installation_client)
    expected_methods = [
      :app_token,
      :app_client,
      :app_installation_token,
      :app_installation_client
    ]
    expected_methods.each do |method|
      expect(auth.public_methods).to include(method)
    end
  end
end
