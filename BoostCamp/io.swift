//
//  IO.swift
//  BoostCamp
//
//  Created by 오민호 on 2017. 6. 5..
//  Copyright © 2017년 오민호. All rights reserved.
//

// 성적 결과 분석 입출력에 필요한 데이터들이 정의된 파일

import Foundation

//formatting 을 위한 extension
extension Double {
    func format(f: String) -> String {
        return String(format :"%\(f)f", self)
    }
}

//성적 입출력을 위한 클래스
class GradeIOManager  {
    let fileManager = FileManager.default
    let homeDirectory = NSHomeDirectory()
    let srcFilePath : String
    let desFilePath : String
    var dataBuffer : Data? = nil
    
    init(srcFileName : String, desFileName : String) {
        self.srcFilePath = self.homeDirectory.appending("/"+srcFileName)
        self.desFilePath = self.homeDirectory.appending("/"+desFileName)
    }
    
    //filePath 가 있는지 확인하고 없다면 nil, 있다면 파일 내용을 반환함
    func readContents() -> Data? {
        if self.fileManager.fileExists(atPath: self.srcFilePath) {
            dataBuffer = self.fileManager.contents(atPath: self.srcFilePath)
        }
        else {
            print("\(self.srcFilePath) 가 존재하지 않습니다.")
        }
        return dataBuffer
    }
    
    //resultBuffer에 문자열을 desFilePath에 쓰는 함수
    func writeContents(resultBuffer: String) {
        fileManager.createFile(atPath: self.desFilePath, contents: nil, attributes: nil)
        let file: FileHandle? = FileHandle(forWritingAtPath: self.desFilePath)
        if file != nil {
            // Set the data we want to write
            let data = resultBuffer.data(using: String.Encoding.utf8)
            // Write it to the file
            file?.write(data!)
            // Close the file
            file?.closeFile()
        }
        else {
            print("GradeIOManager.writeContents 오류 발생")
        }
    }
}
