module Messages
  module Objects
    class Target
      attr_accessor :name, :level

      def initialize(data)
        self.name = data[:name]
        self.level = data[:level]
      end
    end
  end
end
