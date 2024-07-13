defmodule TrafficLights.Light do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:current_light, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:transition, state) do
    new_state =
      case state do
        :green -> :yellow
        :yellow -> :red
        :red -> :green
      end

    {:noreply, new_state}
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :green)
  end

  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  def current_light(pid) do
    GenServer.call(pid, :current_light)
  end
end
