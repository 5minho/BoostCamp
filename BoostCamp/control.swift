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
    var students : [Student]
    var sortedStudents : [Student]? = nil
    var passCriteria : GradeType
    
    init(passCriteria : GradeType) {
        students = []
        sortedStudents = nil
        self.passCriteria = passCriteria
    }
    
    //학생, 점수 추가 함수
    func appendGradeOfStudent(data : [String : Any]) {
        guard let name = data["name"] as? String,
                        let gradeInformation = data["grade"] as? [String : GradeType] else {
                return
        }
        if let student : Student = try? Student.init(name: name, gradeInformation : gradeInformation) {
            students.append(student)
        }
    }
    
    func studentGradeSortedByName() -> String {
        if sortedStudents == nil {
            sortedStudents = Array(students).sorted(by: <)
        }
        return sortedStudents!.reduce("",{$0 + $1.printGradeResult()})
    }
    
    // 전체 평균 계산 함수
    func totalAverageGrade() -> GradeType {
        return students.reduce(0.0){$0 + $1.calcGradeAverage()} / Double(students.count)
    }
    
    func studentsPassed() -> String {
        if sortedStudents == nil {
            sortedStudents = Array(students).sorted(by: <)
        }
        guard let studentPassed = sortedStudents?.filter({(student : Student) -> Bool in return (student.gradeResult?.isPassed())!}).reduce("", {$0 + $1.name + ", "}) else {return ""}
        let endIdx = studentPassed.index((studentPassed.endIndex), offsetBy: -2)
        return studentPassed.substring(to: endIdx)
    }
}
