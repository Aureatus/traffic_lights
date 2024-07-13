defmodule TrafficLights.LightTest do
  use ExUnit.Case
  doctest TrafficLights.Light

  test "initialization config" do
    assert {:ok, _} = TrafficLights.Light.start_link([])
  end

  test "initialization state" do
    {:ok, pid} = TrafficLights.Light.start_link([])
    assert :green = TrafficLights.Light.current_light(pid)
  end

  test "transition state once" do
    {:ok, pid} = TrafficLights.Light.start_link([])
    TrafficLights.Light.transition(pid)
    assert :yellow = TrafficLights.Light.current_light(pid)
  end

  test "transition state twice" do
    {:ok, pid} = TrafficLights.Light.start_link([])
    TrafficLights.Light.transition(pid)
    TrafficLights.Light.transition(pid)
    assert :red = TrafficLights.Light.current_light(pid)
  end

  test "transition state thrice" do
    {:ok, pid} = TrafficLights.Light.start_link([])
    init_state = TrafficLights.Light.current_light(pid)
    TrafficLights.Light.transition(pid)
    TrafficLights.Light.transition(pid)
    TrafficLights.Light.transition(pid)

    assert :green == TrafficLights.Light.current_light(pid) and
             init_state == TrafficLights.Light.current_light(pid)
  end
end

# {:ok, pid} = TrafficLights.Light.start_link([])

# :green = TrafficLights.Light.current_light(pid)
# :ok = TrafficLights.Light.transition(pid)

# :yellow = TrafficLights.Light.current_light(pid)
# :ok = TrafficLights.Light.transition(pid)

# :red = TrafficLights.Light.current_light(pid)
# :ok = TrafficLights.Light.transition(pid)

# :green = TrafficLights.Light.current_light(pid)
