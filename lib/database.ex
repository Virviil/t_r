use Amnesia

defdatabase Database do
  deftable Message, [:id, :text], type: :ordered_set do
    @type t :: %Message{id: binary, text: binary}
  end

  deftable Deps, [:id, :page], type: :ordered_set do
    @type t :: %Deps{id: integer, page: integer}
  end

  deftable Time, [:id, :time], type: :ordered_set do
    @type t :: %Time{id: integer, time: binary}
  end
end
