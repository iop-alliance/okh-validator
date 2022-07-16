# OKH Validator For Makers

This is a manifest validator for the [Internet of Production Alliance's Open Know-How manifests](https://standards.internetofproduction.org/).

An overview of the project and details of the validation process is described in the [overview document](./docs/overview.md).

## Web-based validator

The web-based validator can be accessed at [okh-v1-validator.fly.dev](https://okh-v1-validator.fly.dev)

## API

The endpoint for the REST API is https://okh-v1-validator.fly.dev/validate?manifest=[manifest_url], where [manifest_url] is the url of a manifest that is published online.

The API specifications are available at: https://app.swaggerhub.com/apis/iopa/okh-v1-validator/1.0.0

## Installation

This project uses the [Elixir Phoenix framework](https://www.phoenixframework.org/).

To run locally:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Resources on the Phoenix Framework

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * Ready to run in production? Please [check the deployment guides](https://hexdocs.pm/phoenix/deployment.html).

