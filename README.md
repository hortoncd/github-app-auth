# GitHub::App::Auth

A gem to make (at least) some forms of GitHub App authentication easy.  It is built as an includable module, with the option of a class to
instantiate if preferred.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github-app-auth'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install github-app-auth

## Usage

```
require "github-app-auth"
```

Include the module in your class
```
include GitHub::App::Auth
```

Instantiate the AuthClass class and use the methods from there.
```
auth = GitHub::App:Auth::AuthClass.new
```

### Authenticating as an App

See [the GitHub documentation](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app) for more information.

Applicaiton authentication is required for most (all?) of the other methods of authentication.  To authenticate as the application, two
secrets are required:

- Private Key
- Application ID

The two supported methods are ENV variables, or setting the options in the `options` hash to be passed to the various method calls.

#### Env Vars
```
GITHUB_APP_ID="123456"
GITHUB_APP_PRIVATE_KEY="RSA Private Key ..."
```

#### Options hash
```
{
  github_app_id: "123456",
  github_app_private_key: "RSA Private Key ..."
}
```

### Authenticating as an App Installation

See [the GitHub documentation](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app-installation#generating-an-installation-access-token) for more information.

The examples are using the gem as an includable module, but can also be used with the available AuthClass class..

There are several methods of authenticating as an application installation.

#### Organization Installation

Auth as an application installation for an organization and return an Octokit::Client.
```
client = organization_installation_client("myorg")
```

Alternatively you can retrieve the token, and then set up your own GitHub client (Octokit or whatever you prefer) as needed.
```
token = organization_installation_token("myorg")
client = Octokit::Client.new({ bearer_token: token, ... })
```

#### Repository Installation

Auth as an application installation for a repository and return an Octokit::Client.
```
client = repository_installation_client("myaccount/myrepo")
```

Alternatively you can retrieve the token, and then set up your own GitHub client (Octokit or whatever you prefer) as needed.
```
token = repository_installation_token("myaccount/myrepo")
client = Octokit::Client.new({ bearer_token: token, ... })
```

#### User Installation

Auth as an application installation for a user and return an Octokit::Client.
```
client = user_installation_client("myorg")
```

Alternatively you can retrieve the token, and then set up your own GitHub client (Octokit or whatever you prefer) as needed.
```
token = user_installation_token("myorg")
client = Octokit::Client.new({ bearer_token: token, ... })
```

### Application Auth

If you need to accomplish somehting other than authenticating as an application installation, you can use the app auth to get the initial client authenticated with the app JWT.
```
client = app_client
```

It's also possible to get just the JWT token for use with your own client setup.
```
token = app_token
client = Octokit::Client.enw({ bearer_token: token, ... })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hortoncd/github-app-auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hortoncd/github-app-auth/blob/master/CODE_OF_CONDUCT.md).

Don't forget to add/fix tests for your changes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GitHub::App::Auth project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hortoncd/github-app-auth/blob/master/CODE_OF_CONDUCT.md).
