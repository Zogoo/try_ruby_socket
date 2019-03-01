require 'byebug'

Dir[File.dirname(__FILE__) + "/../../client/*.rb"].each { |file| require file }

module Client
  class TcpTest
    attr_accessor :test_class

    def self.run
      test_obj = new
      test_obj.case_normal_listen
    end

    def initialize
      ip = 'localhost'
      port = '2000'
      self.test_class = Client::Tcp.new(ip, port)
    end

    def case_normal_listen
      test_class.test_listen
      test_class.finish
    end
  end
end

Client::TcpTest.run
