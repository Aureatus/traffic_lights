defmodule TrafficLights.GridTest do
  use ExUnit.Case
  doctest TrafficLights.Grid

  test "initialization config" do
    assert {:ok, _} = TrafficLights.Grid.start_link([])
  end

  test "initialization state" do
    {:ok, pid} = TrafficLights.Grid.start_link([])
    assert [:green, :green, :green, :green, :green] = TrafficLights.Grid.current_lights(pid)
  end

  test "Single transition" do
    {:ok, pid} = TrafficLights.Grid.start_link([])
    TrafficLights.Grid.transition(pid)
    assert [:yellow, :green, :green, :green, :green] = TrafficLights.Grid.current_lights(pid)
  end

  test "Multi transition" do
    {:ok, pid} = TrafficLights.Grid.start_link([])

    TrafficLights.Grid.transition(pid)
    TrafficLights.Grid.transition(pid)
    TrafficLights.Grid.transition(pid)
    TrafficLights.Grid.transition(pid)
    TrafficLights.Grid.transition(pid)
    assert [:yellow, :yellow, :yellow, :yellow, :yellow] = TrafficLights.Grid.current_lights(pid)
  end
end
