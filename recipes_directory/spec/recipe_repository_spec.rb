require 'recipe_repository'

def reset_recipes_table
    seed_sql = File.read('spec/seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

describe RecipeRepository do
    before(:each) do 
        reset_recipes_table
    end
    it "gets all recipes from database" do
        repo = RecipeRepository.new

        recipes = repo.all

        expect(recipes.length).to eq 2

        expect(recipes[0].id).to eq 1
        expect(recipes[0].name).to eq 'Pasta'
        expect(recipes[0].cooking_time).to eq 2
        expect(recipes[0].rating).to eq 4

        expect(recipes[1].id).to eq 2
        expect(recipes[1].name).to eq 'Steak'
        expect(recipes[1].cooking_time).to eq 4
        expect(recipes[1].rating).to eq 5
    end
    it "it gets one record from the database" do
        repo = RecipeRepository.new

        recipe = repo.find(1)

        expect(recipe[0].id).to eq 1
        expect(recipe[0].name).to eq 'Pasta'
        expect(recipe[0].cooking_time).to eq 2
        expect(recipe[0].rating).to eq 4
    end
end