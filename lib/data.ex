defmodule TR.Data do
  use Amnesia
  use Database

  def set_page(page) do
    Amnesia.transaction do
      %Deps{id: 0, page: page}
      |>Deps.write
    end
  end

  def get_page do
    Amnesia.transaction do
      d = Deps.read(0)
      if d == nil do
        0
      else
        d.page
      end
    end
  end

  def set_time(time) do
    Amnesia.transaction do
      %Time{id: 0, time: time}
      |> Time.write
    end
  end

  def get_time do
    Amnesia.transaction do
      t = Time.read(0)
      if t == nil do
        "0"
      else
        t.time
      end
    end
  end


  def dump(data_file_path) do
    {:ok, out} = File.open(data_file_path, [:write, :utf8])
    Amnesia.transaction do
      Message.where(id>"0")
      |> Amnesia.Selection.values
      |> Enum.each(fn mes -> IO.write(out, "#{mes.id} >> #{mes.text}\n") end)
    end
    File.close(out) 
  end
end

