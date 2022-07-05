require 'student_repository'
require 'student'


def reset_students_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'students_test' })
    connection.exec(seed_sql)
  end

  describe StudentRepository do
    before(:each) do 
      reset_students_table
    end
    it "returns all students from database" do
        repo = StudentRepository.new
        students = repo.all
        expect(students.length).to eq 2
        expect(students[0].id).to eq 1
        expect(students[0].name).to eq 'David'
        expect(students[0].cohort_name).to eq 'April 2022'
        expect(students[1].id).to eq 2
        expect(students[1].name).to eq 'Anna'
        expect(students[1].cohort_name).to eq 'May 2022'
    end
  end
