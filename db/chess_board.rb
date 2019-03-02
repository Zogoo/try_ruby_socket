require 'pg'

module Db
  class ChessBoard
    attr_accessor :connection
    attr_accessor :row, :column

    def initialize
      connect_to_db
    end

    def create_new_board
      connection.exec(new_board_query)
    end

    private

    def connect_to_db
      self.connection = PGconn.connect(
        :hostaddr=>"127.0.0.1",
        :port=>5432,
        :dbname=>"ruby_chess",
        :user=>"postgres",
        :password=>''
      )
    end

    def new_board_query
      'INSERT INTO board (rows, columns, style)' +
        'VALUES (' +
          "ARRAY[1,2,3,4,5,6,8]," +
          "ARRAY['a','b','c','d','e','f','g']," +
          "'{ 'black_board' : 'black', 'white_board' : 'white'}'"
    end
  end
end
