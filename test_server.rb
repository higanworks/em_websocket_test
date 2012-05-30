require "bundler"
require "benchmark"

Bundler.setup

require "em-websocket"

@clients = []

EM::WebSocket.start(host: "0.0.0.0", port: 8081) do |ws|
  ws.onopen do
    @clients << ws
    p "open with: #{@clients.size}"
  end

  ws.onmessage do |message|
    puts "on message: #{message}."

    wait_time = message.to_i

    timer = EM::Timer.new(wait_time) do
      ws.send("wait: #{wait_time}s")
      timer.cancel
    end

    puts "complete send message."
  end

  ws.onclose do
    @clients.delete(ws)
  end

  ws.onerror do
    p "err"
  end
end

