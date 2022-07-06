require_relative './database_connection'
require_relative './book'

class BookRepository
    def all
        sql = "SELECT * FROM books;"
        result_set = DatabaseConnection.exec_params(sql, [])
        books = []
        result_set.each do |record|
            book = Book.new
            book.id = record["id"].to_i
            book.title = record["title"]
            book.author_name = record["author_name"]
            books << book
        end
        books
    end
end