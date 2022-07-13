require 'user_repository'

def reset_users_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

describe UserRepository do
    before(:each) do
        reset_users_table
        
    end
    it "gets all users" do
        repo = UserRepository.new

        users = repo.all

        expect(users[0].id).to eq 1
        expect(users[0].username).to eq "David432"
        expect(users[0].email).to eq "david432@yahoo.com"


        expect(users[1].id).to eq 2
        expect(users[1].username).to eq "Anna123"
        expect(users[1].email).to eq "anna123@gmail.com"
    end
    it "gets a single user by id" do
        repo = UserRepository.new
        user = repo.find(1)
        expect(user[0].id).to eq  1
        expect(user[0].username).to eq  "David432"
        expect(user[0].email).to eq  "david432@yahoo.com"
    end
    it "creates a new user record" do
        repo = UserRepository.new

        user = User.new
        user.username = "Paris098"
        user.email = "parismonson@yahoo.com"

        repo.create(user)
        users = repo.all
        expect(users[2].id).to eq  3
        expect(users[2].username).to eq  "Paris098"
        expect(users[2].email).to eq  "parismonson@yahoo.com"
    end
    it "deletes a user record" do
        repo = UserRepository.new
       
        repo.delete("David432")
        users = repo.all

        expect(users[0].id).to eq  2
        expect(users[0].username).to eq  "Anna123"
        expect(users[0].email).to eq "anna123@gmail.com"
    end
end