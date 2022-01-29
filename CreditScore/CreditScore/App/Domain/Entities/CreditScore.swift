//
//  CreditReport.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import Foundation

struct CreditScore: Equatable {
    let score: Double
    let minScore: Double
    let maxScore: Double
    var creditScoreInfo: CreditScoreInfo? = nil
    
    var progressScore: Double {
        return (score / maxScore)
    }
}
