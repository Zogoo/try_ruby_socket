require 'byebug'

Dir[File.dirname(__FILE__) + '/../../server/*.rb'].each { |file|
  require file
}

module Server
  class TcpTest
    attr_accessor :test_class

    def self.run
      test_obj = new
      test_obj.case_normal_send
    end

    def initialize
      ip = 'localhost'
      port = '2000'
      self.test_class = Server::Tcp.new(ip, port)
    end

    def case_normal_send
      loop {
        test_class.listen
        test_class.respond('Okay')
        test_class.finish
      }
    end
  end
end

Server::TcpTest.run
