# TR

**TODO: Add description**

## Configuration

* Install telegram-cli from source

* Install goon

* Run
```bash
mix amnesia.create -db Database --disk
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `t_r` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:t_r, "~> 0.1.0"}]
    end
    ```

  2. Ensure `t_r` is started before your application:

    ```elixir
    def application do
      [applications: [:t_r]]
    end
    ```

