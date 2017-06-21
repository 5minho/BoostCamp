//
//  enum.swift
//  BoostCamp
//
//  Created by 오민호 on 2017. 6. 21..
//  Copyright © 2017년 오민호. All rights reserved.
//

enum Subject {
    case data_structure (GradeType)
    case algorithm (GradeType)
    case networking (GradeType)
    case database (GradeType)
    case operating_system (GradeType)
    
    func value() -> GradeType {
        switch self {
        case .data_structure(let grade):
            return grade
        case .algorithm(let grade):
            return grade
        case .networking(let grade):
            return grade
        case .database(let grade):
            return grade
        case .operating_system(let grade):
            return grade
        }
    }
}

enum GradeResult {
    case A (GradeType)
    case B (GradeType)
    case C (GradeType)
    case D (GradeType)
    case F (GradeType)
    func isPassed() -> Bool {
        switch self {
        case .A, .B, .C:
            return true
        default:
            return false;
        }
    }
    
    func string() -> String {
        switch self {
        case .A:
            return "A"
        case .B:
            return "B"
        case .C:
            return "C"
        case .D:
            return "D"
        case .F:
            return "F"
        }
    }
    
    func value() -> GradeType {
        switch self {
        case .A(let average):
            return average
        case .B(let average):
            return average
        case .C(let average):
            return average
        case .D(let average):
            return average
        case .F(let average):
            return average
        }
    }
}

enum GradeParseError : Error {
    case unknownGrade
}

enum GradeCalculationError : Error {
    case zeroDivede
}
