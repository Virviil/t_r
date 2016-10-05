defmodule TR.Api do
  @lara_id "$050000007b68993eade1ac0dcb1da26d"
  require Logger

  use Database
  use Amnesia

  def phone do
    Application.get_env(:t_r, :phone)
  end

  def number_of_messages do
    Application.get_env(:t_r, :message_size)
  end

  def data_file_path do
    Application.get_env(:t_r, :data_file_path)
  end

  def write_to_file do
    Logger.debug "Starting process!"
    #{:ok, out} = File.open(data_file_path, [:append, :utf8])
    get_data(get_time)
    #for elem <- data do
    #  IO.write(out, "#{elem["date"]}: #{elem["text"]}\n")
    #end
    #last = data
    #|> Enum.at((data |> Enum.count)-1)
    #{:ok, time_file} = File.open(time_file_path, [:write, :utf8])
    #IO.write(time_file, last["date"])
    #File.close(out) 
    Logger.debug "Ending process!"
  end

  def get_data(prev_cycle_id) do
    do_get_data(prev_cycle_id, get_page)
  end

  defp do_get_data(prev_cycle_id, page \\ 0) do
    Logger.debug "Page: #{page}"
    {:ok, data} = TgClient.Session.send_command(phone, "history", [@lara_id, message_size, page*message_size])
    data = data
    |> Poison.Parser.parse!

    Logger.debug "Downloaded: #{Enum.count(data)} messages."

    data = data
    |> Enum.filter(&(text_message?(&1)))
    |> Enum.map(&adjust_id/1)

    write_messages(data)
    set_page(page+1)
    if data |> Enum.all?(&(younger_then_previous?(&1, prev_cycle_id))) do
      if Enum.count(data) == 0 do
        set_time(last_message_id)
        set_page(0)
      else
        do_get_data(prev_cycle_id, page + 1)
      end
    else
      set_time(last_message_id)
      set_page(0)
    end
  end

  defp text_message?(message), do: message["text"] != nil

  defp last_message_id do
    Amnesia.transaction do
      m = Message.last
      if m == nil do
        0
      else
        m.id
      end
    end
  end

  defp younger_then_previous?(message, prev_message_id), do: message["id"] > prev_message_id

  defp write_messages(messages) do
    for message <-messages do
      write_message(message)
    end
  end

  defp adjust_id(message) do
    <<_::binary-size(16),
      f0::binary-size(2),
      f1::binary-size(2),
      f2::binary-size(2),
      f3::binary-size(2),
      f4::binary-size(2),
      f5::binary-size(2),
      f6::binary-size(2),
      f7::binary-size(2),
      _::binary>> = message["id"]
    %{message| "id" => <<f7::binary, f6::binary, f5::binary, f4::binary, f3::binary, f2::binary, f1::binary, f0::binary>>}
  end

  defp write_message(%{"id" => id, "text" => text}) do
    Amnesia.transaction do
      %Message{id: id, text: text}
      |> Message.write
    end
  end
end
