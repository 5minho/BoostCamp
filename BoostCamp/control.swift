//
//  GradeManager.swift
//  BoostCamp
//
//  Created by 오민호 on 2017. 6. 5..
//  Copyright © 2017년 오민호. All rights reserved.
//

// 성적 계산을 위한 클래스들을 정의한 swift 파일

//성적관리 클래스
class GradeManager {
    var gradeOfStudent : [Student : [Grade]]
    var resultOfStudent : [Student : ResultType]
    var passCriteria : GradeType
    
    init(passCriteria : GradeType) {
        self.gradeOfStudent = [:]
        self.resultOfStudent = [:]
        self.passCriteria = passCriteria
    }
    
    //학생, 점수 추가 함수
    func appendGradeOfStudent(data : [String : Any]) {
        guard let name = data["name"] as? String,
                        let gradeJSON = data["grade"] as? [String : GradeType] else {
                return
        }
        
        let student : Student = Student.init(name: name)
        var grades : [Grade] = []
        for (subject, gradeValue) in gradeJSON {
            let grade : Grade = Grade.init(subject: subject, subjectGrade: gradeValue)
            grades += [grade]
        }
        self.gradeOfStudent[student] = grades
        self.resultOfStudent[student] = self.studentResult(student: student)
    }
    
    // 학생 별 총 평균 계산 함수
    func studentAverageGrade(student : Student) -> Double? {
        if let grades = gradeOfStudent[student] {
            return grades.reduce(0.0){$0 + $1.subjectGrade} / Double(grades.count)
        }
        return nil
    }
    
    // 학생 별 학점 계산 함수
    func studentResult(student : Student) -> ResultType {
        var result : ResultType = "F";
        if let average = studentAverageGrade(student: student) {
            switch average {
            case 90.0 ... 100.0 :
                result = "A"
            case 80.0 ... 90.0 :
                result = "B"
            case 70.0 ... 80.0 :
                result = "C"
            case 60.0 ... 70.0 :
                result = "D"
            default :
                result = "F"
            }
        }
        return result
    }
    
    // 전체 평균 계산 함수
    func totalAverageGrade() -> GradeType {
        var totalSum : GradeType = 0.0
        for (student , _) in self.gradeOfStudent {
            if let avg = self.studentAverageGrade(student: student) {
                totalSum += avg
            }
        }
        return totalSum / Double(gradeOfStudent.count)
    }
    
    //학생들을 이름순으로 정렬한 결과 반환
    func sortByStudentName() -> Array<Student> {
        return Array(self.resultOfStudent.keys).sorted(by: <)
    }
    
    //student의 수료기준 달성 여부 반환
    func isPass(student: Student) -> Bool? {
        if let avg = self.studentAverageGrade(student: student) {
            return avg >= self.passCriteria
        }
        return nil
    }
}
