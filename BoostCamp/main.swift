////
////  main.swift
////  BoostCamp
////
////  Created by 오민호 on 2017. 6. 1..
////  Copyright © 2017년 오민호. All rights reserved.
////
//
import Foundation

//학생들 점수 타입
typealias GradeType = Double
//결과 타입
typealias ResultType = String

//합격기준 70.0 인 성적관리클래스 생성
let gradeManager : GradeManager = GradeManager(passCriteria: 70.0)
//입력파일 "students.json", 출력파일 "result.txt" 인 성적입출력관리클래스 생성
let gradeIOManager : GradeIOManager = GradeIOManager(srcFileName: "students.json", desFileName: "result.txt")

// 파일의 json 데이터를 파싱해서 gradeManager클래스에 student, grade 정보 전달
if let fileContents = gradeIOManager.readContents() {
    if let data = try? JSONSerialization.jsonObject(with: fileContents) as? [Any],
        let anyArrayBinded = data {
        for case let jsonData in anyArrayBinded {
            if let studentData = jsonData as? [String : Any] {
                gradeManager.appendGradeOfStudent(data: studentData)
            }
        }
    }
}

// resultText 에 결과를
var resultText : String = ""
resultText += "성적결과표\n\n"
resultText += "전체 평균 : \(gradeManager.totalAverageGrade().format(f: ".2"))\n\n"
resultText += "개인별 학점\n"
let sortedByStudentName = gradeManager.sortByStudentName()

for s in sortedByStudentName {
    resultText += String(format:"%-11s", (s.name as NSString).utf8String!)
    resultText += ": \(gradeManager.resultOfStudent[s]!)" + "\n"
}

resultText += "\n수료생\n"
//합격한 학생들
var passedStudentName = ""
for s in sortedByStudentName {
    if let isPassed = gradeManager.isPass(student: s) {
        if isPassed {
            passedStudentName += ((s.name) + ", ")
        }
    }
}
//passedStudentName 문자열에서 맨뒤 ", "를 제외
let endIndex = passedStudentName.index(passedStudentName.endIndex, offsetBy: -2)
resultText += passedStudentName.substring(to: endIndex)

// 작업을 수행하고 결과파일 생성
gradeIOManager.writeContents(resultBuffer: resultText)




