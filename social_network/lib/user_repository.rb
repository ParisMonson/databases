require_relative './user'
require_relative './database_connection'

class UserRepository

  # Selecting all records
  # No arguments
  def all
    sql = "SELECT * FROM users;"
    result_set = DatabaseConnection.exec_params(sql, [])
    convert(result_set)
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = "SELECT * FROM users WHERE id = $1;"
    result = DatabaseConnection.exec_params(sql, [id])
    convert(result)
  end

   def create(user)
    sql = "INSERT INTO users (username, email) VALUES ($1, $2);"
    DatabaseConnection.exec_params(sql, [user.username, user.email])
   end

   def delete(username)
      sql = "DELETE FROM users WHERE username = $1 ;"
      DatabaseConnection.exec_params(sql, [username])
   end

   private

   def convert(result_set)
        users = []
        result_set.each do |record|
            user = User.new
            user.id = record["id"].to_i
            user.username = record["username"]
            user.email = record["email"]
            users << user
        end
        users
   end
end