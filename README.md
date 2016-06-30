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
