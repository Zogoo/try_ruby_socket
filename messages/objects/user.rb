module Messages
  module Objects
    class User
      attr_accessor :user_name

      def initialize(user)
        self.user_name = user[:user_name]
      end
    end
  end
end
