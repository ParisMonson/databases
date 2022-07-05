require 'student'

class StudentRepository
    def all
        students = []
        sql = 'SELECT * FROM students;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            student = Student.new
            student.id = record["id"].to_i
            student.name = record["name"]
            student.cohort_name = record["cohort_name"]
            students << student
        end
        students
    end

    def find(id)

    end
    def create(student)

    end

end