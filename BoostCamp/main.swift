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
//합격기준 70.0 인 성적관리클래스 생성
let gradeManager = GradeManager()
//입력파일 "students.json", 출력파일 "result.txt" 인 성적입출력관리클래스 생성
let gradeIOManager = GradeIOManager(srcFileName: "students.json", desFileName: "result.txt")

func jsonToStudentGradeObject(fileContents : Data?) {
    guard let data = try? JSONSerialization.jsonObject(with: fileContents!) as? [Any] else {return }
    guard let anyArray = data else {return }
    for case let jsonData in anyArray {
        guard let studentData = jsonData as? [String : Any] else {return}
        gradeManager.appendGradeOfStudent(data: studentData)
    }
}

if let fileContents = gradeIOManager.readContents() {
    jsonToStudentGradeObject(fileContents: fileContents)
}

// resultText 에 작업 결과를 저장
var resultText : String = ""
resultText += "성적결과표\n\n"
resultText += "전체 평균 : \(gradeManager.totalAverageGrade().format(f: ".2"))\n\n"
resultText += "개인별 학점\n"
resultText += gradeManager.studentGradeSortedByName()
resultText += "\n수료생\n"
resultText += gradeManager.studentsPassed()
// 작업을 수행하고 결과파일 생성
gradeIOManager.writeContents(resultBuffer: resultText)




