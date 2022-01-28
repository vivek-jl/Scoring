//
//  CreditScoreDTO.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import Foundation

struct CreditScoreDTO: Codable {
    let accountIDVStatus: String
    let creditReportInfo: CreditReportDetailsDTO
    let dashboardStatus, personaType: String
    let coachingSummary: CoachingSummaryDTO
    let augmentedCreditScore: Int?
}



