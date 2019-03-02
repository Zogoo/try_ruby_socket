require 'json'

Dir[File.dirname(__FILE__) + '/../objects/*.rb'].each { |file| require file }

module Messages
  class Acknowledge
    attr_accessor :parsed_message, :user

    ACCEPTED_KEYS = %w(username).freeze

    def initialize(data)
      self.parsed_message = JSON.parse(parsed_message)
    end

    def analyze
      validate!
      self.user = Objects::User.new(parsed_message)
    end

    # TODO: Validation service will help
    def validate!
      white_listed_keys = {}
      parsed_message.each do |key, value|
        white_listed_keys[key] = value if ACCEPTED_KEYS.include?(value)
      end
      raise 'wrong body for connection' if white_listed_keys.empty?
      self.parsed_message = white_listed_keys
    end
  end
end
