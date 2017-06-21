//
//  student.swift
//  BoostCamp
//
//  Created by 오민호 on 2017. 6. 5..
//  Copyright © 2017년 오민호. All rights reserved.
//

// 데이터적인 성격이 강한 구조체들을 정의한 swift 파일
import Foundation

//학생 클래스
class Student {
    let name : String
    var grades : [Subject]
    var average : Double
    var gradeResult : GradeResult?
    
    init(name : String, gradeInformation: [String : GradeType]) throws {
        self.average = 0
        self.name = name
        grades = []
        do {
            try setGrades(gradeInformation: gradeInformation)
        }
        catch {
            throw GradeParseError.unknownGrade
        }
    }
    
    func setGrades(gradeInformation : [String : GradeType]) throws {
        for (subjectName, grade) in gradeInformation {
            switch subjectName {
            case "data_structure":
                grades.append(Subject.data_structure(grade))
            case "algorithm":
                grades.append(Subject.algorithm(grade))
            case "networking":
                grades.append(Subject.networking(grade))
            case "database":
                grades.append(Subject.database(grade))
            case "operating_system":
                grades.append(Subject.operating_system(grade))
            default:
                throw GradeParseError.unknownGrade
            }
        }
    }
    
    func calcGradeAverage() -> GradeType{
        let average = grades.reduce(0.0){$0 + $1.value()} / GradeType(grades.count)
        switch average {
        case 90.0 ... 100.0 :
            gradeResult = GradeResult.A(average)
        case 80.0 ... 90.0 :
            gradeResult = .B(average)
        case 70.0 ... 80.0 :
            gradeResult = .C(average)
        case 60.0 ... 70.0 :
            gradeResult = .D(average)
        default :
            gradeResult = .F(average)
        }
        return average
    }
    
    func printGradeResult() -> String {
        guard let result = self.gradeResult else {return ""}
        return String(format:"%-11s", (self.name as NSString).utf8String!) + ": \(result.string())\n"
    }
}

//GradeManager 클래스에서 key : Student, value : [grade] 로 저장하기 때문에 Hashable 프로토콜 적용
extension Student : Hashable {
    var hashValue : Int {
        return name.hash
    }
}
//해당 문제에서 추가 요구사항전까지는 이름을 기준으로 학생들을 구분함
func == (lhs : Student, rhs : Student) -> Bool {
    return lhs.name == rhs.name
}

//정렬를 위해 재정의
func < (lhs : Student, rhs : Student) -> Bool {
    return lhs.name < rhs.name
}



