require 'socket'

module Server
  class Tcp
    attr_accessor :server, :address, :port
    attr_accessor :connection

    def initialize(address, port)
      self.address = address
      self.port = port
      self.server = TCPServer.open(port)
    end

    def listen
      self.connection = server.accept
    end

    def respond(message)
      connection.puts message.to_s
    end

    def finish
      connection.close
    end
  end
end
