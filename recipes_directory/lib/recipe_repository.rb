require_relative './database_connection'
require_relative './recipe'
DatabaseConnection.connect("recipes_directory_test")
class RecipeRepository
    def all
        sql = "SELECT * FROM recipes;"
        result_set = DatabaseConnection.exec_params(sql, [])
        create_recipe_objects(result_set) #returns an array of recipe objects
    end

    def find(id)
        sql = "SELECT * FROM recipes WHERE id = $1;"
        result_set = DatabaseConnection.exec_params(sql, [id])
        create_recipe_objects(result_set)
    end

    private

    def create_recipe_objects(result_set)
        recipes = []
        result_set.each do |record|
            recipe = Recipe.new
            recipe.id = record["id"].to_i
            recipe.name = record["name"]
            recipe.cooking_time = record["cooking_time"].to_i
            recipe.rating = record["rating"].to_i
            recipes << recipe
        end
        recipes
    end
end