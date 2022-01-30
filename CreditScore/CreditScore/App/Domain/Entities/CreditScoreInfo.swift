//
//  CreditScoreInfo.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation

struct CreditScoreInfo: Equatable {
    let monthsSinceLastDefaulted: Int
    let monthsSinceLastDelinquent: Int
    let hasEverDefaulted: Bool
    let hasEverBeenDelinquent: Bool
    let percentageCreditUsed: Int
    let currentLongTermDebt: Int
    let currentLongTermNonPromotionalDebt: Int
}
