require_relative './lib/recipe_repository'

DatabaseConnection.connect("recipes_directory")

repo = RecipeRepository.new

repo.all.each do |recipe|
    puts "#{recipe.id}: #{recipe.name}, Cooked in: #{recipe.cooking_time} mins #{recipe.rating}/5."
end

