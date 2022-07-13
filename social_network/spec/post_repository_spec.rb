require 'post_repository'

def reset_posts_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

describe PostRepository do
    before(:each) do
        reset_posts_table
    end
    it "gets all posts" do
        repo = PostRepository.new

        posts = repo.all

        expect(posts[0].id).to eq  1
        expect(posts[0].title).to eq  "Happy Birthday"
        expect(posts[0].content).to eq  "Have a good day"
        expect(posts[0].views).to eq  122
        expect(posts[0].user_id).to eq  1


        expect(posts[1].id).to eq  2
        expect(posts[1].title).to eq  "Morning"
        expect(posts[1].content).to eq  "Random stuff"
        expect(posts[1].views).to eq  600
        expect(posts[1].user_id).to eq  2
    end
    it "gets a single post" do
        repo = PostRepository.new
        post = repo.find(1)

        expect(post[0].id).to eq   1
        expect(post[0].title).to eq   'Happy Birthday'
        expect(post[0].content).to eq   'Have a good day'
        expect(post[0].views).to eq  122
        expect(post[0].user_id).to eq  1
    end
    it "creates a new post" do
        repo = PostRepository.new

        post = Post.new
        post.title = "Test"
        post.content = "Some stuff here"
        post.views = 600
        post.user_id = 1

        repo.create(post)
        posts = repo.all
        expect(posts[2].title).to eq "Test"
        expect(posts[2].content).to eq "Some stuff here"
        expect(posts[2].views).to eq 600
        expect(posts[2].user_id).to eq 1
    end
    it "deletes a post record by id" do
        repo = PostRepository.new

        repo.delete(1)

        posts = repo.all

        expect(posts[0].title).to eq  'Morning'
        expect(posts[0].content).to eq  'Random stuff'
        expect(posts[0].views).to eq  600
        expect(posts[0].user_id).to eq  2
    end
end