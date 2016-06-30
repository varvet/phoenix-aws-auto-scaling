# MyApp

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

Blog post steps:

## Build local release

We assume that you've generated a Phoenix app and got it running with `mix phoenix.server` which in short involves:

```sh
brew install erlang
brew install elixir
git clone https://github.com/phoenixframework/phoenix.git
cd phoenix
mix do deps.get, compile
mix phoenix.new ../my_app
cd ../my_app
mix do deps.get, compile
mix phoenix.server
```

This repo is generated with `mix phoenix.new my_app --no-brunch --no-ecto --no-html` to run into less dependency issues.

We then need to add the mix package exrm by adding it to `mix.exs`:

```elixir
def deps do
  […, {:exrm, "~> 1.0.6"}]
end
```

You should now be able to release your app with:

```sh
MIX_ENV=prod mix do compile, release
rel/my_app/bin/my_app console # to see that it works
```

## Build compatible release

You should now have a binary that contains everything you need to run the application. The only catch is that it's compiled for your OS which probably isn't the same as your server's. But what about your CI server? Travis CI runs on Ubuntu, let's use that!

#### S3

Sign up for AWS and create a S3 bucket, we'll name it *my-app-builds*. Then create two IAM users one with read and one with [write access](https://gist.github.com/ramhoj/7fa795a68f5eec09046a9ae18c03d8da) only to *my-app-builds*.

#### Configure .travis.yml

```yml
language: elixir
elixir:
  - 1.2.4
otp_release:
  - 18.1
addons:
  s3_region: "eu-central-1"
  artifacts:
    key: iam_write_key
    secret: iam_write_secret
    bucket: my-app-builds
    region: "eu-central-1"
    paths:
      - ./my_app_prod.tar.gz
    target_paths: "$TRAVIS_COMMIT"
script:
  - mix test --exclude noci
after_success:
  - MIX_ENV=prod mix do compile, release
  - cp rel/my_app/releases/*/my_app.tar.gz my_app_prod.tar.gz
```

We'll be building the app with our prod config, but you can easily add e.g a staging build and have Travis build them both for you. Make sure you've told Travis to build your repo, commit and push and you should see the build in your S3 bucket after a few minutes.
