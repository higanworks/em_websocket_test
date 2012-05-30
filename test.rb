require "bundler"
Bundler.setup

require "celluloid/io"

class EchoClient
  include Celluloid::IO

  def initialize(host, port)
    @socket = TCPSocket.from_ruby_socket(::TCPSocket.new(host, port))
  end
  def echo(s)
    @socket.write(s)
    #actor = Celluloid.current_actor
  end
end

socket = nil
1000.times do
  socket = EchoClient.new("127.0.0.1", 8081)
end

socket.echo("aaa")

sleep 1
