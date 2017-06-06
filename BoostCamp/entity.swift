//
//  student.swift
//  BoostCamp
//
//  Created by 오민호 on 2017. 6. 5..
//  Copyright © 2017년 오민호. All rights reserved.
//

// 데이터적인 성격이 강한 구조체들을 정의한 swift 파일

//학생 구조체
struct Student {
    var name : String
    
    init(name : String) {
        self.name = name
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

//과목들
enum Subject : Int {
    case data_structure = 0
    case algorithm
    case networking
    case database
    case operating_system
    case unknown_subject
}

// Grade 구조체
struct Grade {
    //과목
    var subjectId : Subject
    //과목 점수
    var subjectGrade : GradeType
    
    init(subject : String, subjectGrade : GradeType) {
        self.subjectId = Subject.unknown_subject
        switch subject {
        case "data_structure":
            self.subjectId = Subject.data_structure
        case "algorithm":
            self.subjectId = .algorithm
        case "networking":
            self.subjectId = .networking
        case "database":
            self.subjectId = .database
        case "operating_system":
            self.subjectId = .operating_system
        default:
            print("해당 과목은 없습니다")
        }
        self.subjectGrade = subjectGrade
    }
}
