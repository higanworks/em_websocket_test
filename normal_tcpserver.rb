require 'logger'
require 'socket'
require 'monitor'

server = TCPServer.open("localhost", 8081)

$log = Logger.new(STDOUT)
$count = 0
$mon = Monitor.new

while true
  Thread.start(server.accept) do |s|
    $mon.synchronize do
      $count += 1
      $log.info "connet: #{$count}"
    end

    while s.gets
      $log.info "gets"
    end
  end
end
