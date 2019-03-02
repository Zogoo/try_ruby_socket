require "json"

Dir[File.dirname(__FILE__) + "/../server/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../messages/*.rb"].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../memory/*.rb"].each { |file| require file }

module Service
  class Dispatcher
    MAIN_PORT = 2_000

    def main
      main_server = Server::Tcp.new('localhost', MAIN_PORT)
      loop {
        new_connection = main_server.listen
        Thread.start(new_connection) do |connection|
          loop {
            message = connection.gets.chomp
            if message.eql?('exit')
              connection.close
              raise StopIteration
            end

            begin
              msg_obj = Messages::Parser.new(message)
              msg_obj.analyze
              response = Service::Command.execute(connection, msg_obj)
              connection.puts response
            rescue => e
              connection.close
              puts e.message
              raise StopIteration
            end
          }
        end
      }
    end

  end
end
