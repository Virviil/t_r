# TR

TR is telegram dialog dumper application. It's running in the background,
dumps text data of selected telegram dialogs to `mnesia` database. This data
can be then used anywhere - for example in your `Phoenix` application.

## Installation

1. Install [telegram-cli](https://github.com/vysheng/tg). Buildit from the last working source.
2. Install [goon](https://github.com/alco/goon) from the source.
3. Clone this repo and get all dependencies:
  
  ```bash
  mix deps.get
  ```
4. Configure application, making modifications in `config/config.exs`
as it's done in example `config/config.exs.example` file.
5. Create `mnesia` database, using:
  
  ```bash
  mix amnesia.create -db Database --disk
  ```
6. Start application running
  
  ```bash
  elixir --detached -S mix run
  ```

