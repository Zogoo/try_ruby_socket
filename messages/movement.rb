require 'json'

Dir[File.dirname(__FILE__) + '/../objects/*.rb'].each { |file| require file }

module Messages
  class Movement

    attr_accessor :parsed_message, :type
    attr_accessor :user, :target, :start_point, :end_point

    MOVEMENT_KEYS = %w(type user target start_point end_point).freeze
    MSG_TYPE_KEYS = %w(move take)

    def read(data)
      self.parsed_message = JSON.parse(data)
    end

    def analyze
      validate!
      self.type = parsed_message[:user] if MSG_TYPE_KEYS.include?(parsed_message[:user])
      self.user = Objects::User.new(parsed_message[:user])
      self.target = Objects::Target.new(parsed_message[:target])
      self.start_point = parsed_message[:start_point]
      self.end_point = parsed_message[:end_point]
    end

    def validate!
      white_listed_keys = {}
      parsed_message.each do |key, value|
        white_listed_keys[key] = value if MOVEMENT_KEYS.include?(key)
      end
      self.parsed_message = white_listed_keys
    end
  end
end
