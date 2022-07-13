require 'post'

class PostRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = "SELECT * FROM posts;"
      result_set = DatabaseConnection.exec_params(sql, [])
      convert(result_set)
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      sql = "SELECT * FROM posts WHERE id = $1;"
      result = DatabaseConnection.exec_params(sql, [id])
      convert(result)
    end
  
    # Add more methods below for each operation you'd like to implement.
  
      # adds a single record to posts
      # takes a post object as an argument
     def create(post)
     # Executes the SQL query:
        sql = "INSERT INTO posts (title, content, views, user_id) 
        VALUES ($1, $2, $3, $4);"
        params = [post.title, post.content, post.views, post.user_id]
        DatabaseConnection.exec_params(sql, params)
    
  
     end
  
     def delete(post_id)
        # Executes the SQL query:
        sql = "DELETE FROM posts 
         WHERE id = $1;"
         DatabaseConnection.exec_params(sql, [post_id]) 
        
        # Returns nothing 
     end

     private

     def convert(result_set)
        posts = []
        result_set.each do |record|
            post = Post.new
            post.id = record["id"].to_i
            post.title = record["title"]
            post.content = record["content"]
            post.views = record["views"].to_i
            post.user_id = record["user_id"].to_i
            posts << post
        end
        posts
   end
  end