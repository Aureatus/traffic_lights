defmodule TrafficLights.Grid do
  use GenServer

  def init(_opts) do
    lights =
      Enum.map(1..5, fn _ ->
        {:ok, pid} = TrafficLights.Light.start_link([])
        pid
      end)

    {:ok, %{light_pids: lights, transition_index: 0}}
  end

  def handle_cast(:transition, state) do
    Enum.at(state.light_pids, state.transition_index) |> TrafficLights.Light.transition()
    {:noreply, Map.update!(state, :transition_index, &(&1 + 1))}
  end

  def handle_call(:current_lights, _from, state) do
    lights = Enum.map(state.light_pids, fn pid -> TrafficLights.Light.current_light(pid) end)
    {:reply, lights, state}
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  def current_lights(pid) do
    GenServer.call(pid, :current_lights)
  end
end
