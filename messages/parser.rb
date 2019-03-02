require "json"

Dir[File.dirname(__FILE__) + '/../objects/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + './*.rb'].each { |f| require f}

module Messages
  class Parser
    def initialize(data)
      parsed_message = JSON.parse(data)
      raise 'missing message type' if parsed_message[:type].nil?
      raise 'missing message body' if parsed_message[:body].nil?
      clazz = Object.const_get(parsed_message[:type].to_s.capitalize)
      raise 'wrong type' if clazz.nil?
      clazz.new(parsed_message[:body])
    end
  end
end
