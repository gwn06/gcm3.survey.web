# Gcm3
## Stack I used
  * Elixir            - 1.17.2-otp-27
  * Erlang            - 27.0.1
  * Phoenix Framework - 1.17.14
  * Postgresql
  * Tailwind CSS

## Run phoenix server:
  * cd project_name
  * mix deps.get // to get dependencies
  * mix ecto.create
  * mix ecto.migrate
  * mix phx.server
  
## Alternative to run phoenix server:
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`


## Run docker compose
  * docker compose up -t
  * docker exec -it {image_name} /bin/sh
  * > ./bin/migrate


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
