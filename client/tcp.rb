require 'socket'

Dir[File.dirname(__FILE__) + "/../messages/*.rb"].each { |file| require file }

module Client
  class Tcp
    attr_accessor :client, :address, :port
    attr_accessor :raw_message

    include Messages

    def initialize(address, port)
      self.address = address
      self.port = port
      self.client = TCPSocket.new(address, port)
    end

    def listen
      while request = client.gets
        if request.eql?('start')
          raw_message += request
        elsif request.eql?('end')
          mgs = Movement.new(raw_message)
          mgs.analyze
        end
      end
    end

    # TODO: remove
    def test_listen
      puts "Starting the Client..................."
      while message = client.gets             # Read lines from the socket
         puts message.chomp
      end
    end

    def send(message)
      client.puts(message)
    end

    def finish
      client.close
    end
  end
end
