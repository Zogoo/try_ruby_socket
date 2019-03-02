
module Memory
  class Connection
    @@connection = {}

    def self.add_if_not_exists(username, connection)
      add(username, connection) unless check(username, connection)
    end

    def self.check(username, connection)
      !@@connection[username].nil?
    end

    def self.add(username, connection)
      @@connection[username] = connection
    end

    def self.release(username, connection)
      @@connection[username] = nil
      connection.kill
    end
  end
end
