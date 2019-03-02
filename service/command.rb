require "json"

Dir[File.dirname(__FILE__) + '/../server/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) * '/../messages/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + "/../memory/*.rb"].each { |file| require file }

module Service
  class Command
    def self.execute(connection, message)
      case message.class
      when Acknowledge
        Memory::Connection.add_if_not_exists(message.user.username, connection)
      when Movement
        if Memory::Connection.check(message.user.username, connection)
          raise 'You are not allowed to move it'
        end
        
      end
    end
  end
end
